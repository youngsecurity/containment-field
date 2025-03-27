#!/usr/bin/env bash
set -Eeuo pipefail

# Docker environment variables

: "${MAC:=""}"
: "${DHCP:="N"}"
: "${NETWORK:="Y"}"
: "${HOST_PORTS:=""}"
: "${USER_PORTS:=""}"

: "${VM_NET_DEV:=""}"
: "${VM_NET_TAP:="qemu"}"
: "${VM_NET_MAC:="$MAC"}"
: "${VM_NET_HOST:="QEMU"}"
: "${VM_NET_IP:="20.20.20.21"}"

# Second interface environment variables
: "${MAC2:=""}"
: "${DHCP2:="N"}"
: "${NETWORK2:="N"}"  # Default to disabled

: "${VM_NET2_DEV:=""}"
: "${VM_NET2_TAP:="qemu2"}"
: "${VM_NET2_MAC:="$MAC2"}"
: "${VM_NET2_HOST:="QEMU2"}"
: "${VM_NET2_IP:="30.30.30.31"}"

: "${DNSMASQ_OPTS:=""}"
: "${DNSMASQ:="/usr/sbin/dnsmasq"}"
: "${DNSMASQ_CONF_DIR:="/etc/dnsmasq.d"}"

ADD_ERR="Please add the following setting to your container:"

# ######################################
#  Functions
# ######################################

configureDHCP() {

  # Create the necessary file structure for /dev/vhost-net
  if [ ! -c /dev/vhost-net ]; then
    if mknod /dev/vhost-net c 10 238; then
      chmod 660 /dev/vhost-net
    fi
  fi

  # Create a macvtap network for the VM guest
  { ip link add link "$VM_NET_DEV" name "$VM_NET_TAP" address "$VM_NET_MAC" type macvtap mode bridge ; rc=$?; } || :

  if (( rc != 0 )); then
    error "Cannot create macvtap interface. Please make sure that the network type is 'macvlan' and not 'ipvlan',"
    error "that your kernel is recent (>4) and supports it, and that the container has the NET_ADMIN capability set." && return 1
  fi

  while ! ip link set "$VM_NET_TAP" up; do
    info "Waiting for MAC address $VM_NET_MAC to become available..."
    sleep 2
  done

  local TAP_NR TAP_PATH MAJOR MINOR
  TAP_NR=$(</sys/class/net/"$VM_NET_TAP"/ifindex)
  TAP_PATH="/dev/tap${TAP_NR}"

  # Create dev file (there is no udev in container: need to be done manually)
  IFS=: read -r MAJOR MINOR < <(cat /sys/devices/virtual/net/"$VM_NET_TAP"/tap*/dev)
  (( MAJOR < 1)) && error "Cannot find: sys/devices/virtual/net/$VM_NET_TAP" && return 1

  [[ ! -e "$TAP_PATH" ]] && [[ -e "/dev0/${TAP_PATH##*/}" ]] && ln -s "/dev0/${TAP_PATH##*/}" "$TAP_PATH"

  if [[ ! -e "$TAP_PATH" ]]; then
    { mknod "$TAP_PATH" c "$MAJOR" "$MINOR" ; rc=$?; } || :
    (( rc != 0 )) && error "Cannot mknod: $TAP_PATH ($rc)" && return 1
  fi

  { exec 30>>"$TAP_PATH"; rc=$?; } 2>/dev/null || :

  if (( rc != 0 )); then
    error "Cannot create TAP interface ($rc). $ADD_ERR --device-cgroup-rule='c *:* rwm'" && return 1
  fi

  { exec 40>>/dev/vhost-net; rc=$?; } 2>/dev/null || :

  if (( rc != 0 )); then
    error "VHOST can not be found ($rc). $ADD_ERR --device=/dev/vhost-net" && return 1
  fi

  NET_OPTS="-netdev tap,id=hostnet0,vhost=on,vhostfd=40,fd=30"

  return 0
}

configureDNS() {

  # dnsmasq configuration:
  DNSMASQ_OPTS+=" --dhcp-range=$VM_NET_IP,$VM_NET_IP --dhcp-host=$VM_NET_MAC,,$VM_NET_IP,$VM_NET_HOST,infinite --dhcp-option=option:netmask,255.255.255.0"

  # Create lease file for faster resolve
  echo "0 $VM_NET_MAC $VM_NET_IP $VM_NET_HOST 01:$VM_NET_MAC" > /var/lib/misc/dnsmasq.leases
  chmod 644 /var/lib/misc/dnsmasq.leases

  # Set DNS server and gateway
  DNSMASQ_OPTS+=" --dhcp-option=option:dns-server,${VM_NET_IP%.*}.1 --dhcp-option=option:router,${VM_NET_IP%.*}.1"

  # Add DNS entry for container
  DNSMASQ_OPTS+=" --address=/host.lan/${VM_NET_IP%.*}.1"

  DNSMASQ_OPTS=$(echo "$DNSMASQ_OPTS" | sed 's/\t/ /g' | tr -s ' ' | sed 's/^ *//')

  if ! $DNSMASQ ${DNSMASQ_OPTS:+ $DNSMASQ_OPTS}; then
    error "Failed to start dnsmasq, reason: $?" && return 1
  fi

  return 0
}

getUserPorts() {

  local args=""
  local list=$1
  local ssh="22"
  local rdp="3389"

  [ -z "$list" ] && list="$ssh,$rdp" || list+=",$ssh,$rdp"

  list="${list/,/ }"
  list="${list## }"
  list="${list%% }"

  for port in $list; do
    args+="hostfwd=tcp::$port-$VM_NET_IP:$port,"
  done

  echo "${args%?}"
  return 0
}

getHostPorts() {

  local list=$1
  local vnc="5900"
  local web="8006"

  [ -z "$list" ] && list="$web" || list+=",$web"

  if [[ "${DISPLAY,,}" == "vnc" ]] || [[ "${DISPLAY,,}" == "web" ]]; then
    [ -z "$list" ] && list="$vnc" || list+=",$vnc"
  fi

  [ -z "$list" ] && echo "" && return 0

  if [[ "$list" != *","* ]]; then
    echo " ! --dport $list"
  else
    echo " -m multiport ! --dports $list"
  fi

  return 0
}

configureUser() {

  NET_OPTS="-netdev user,id=hostnet0,host=${VM_NET_IP%.*}.1,net=${VM_NET_IP%.*}.0/24,dhcpstart=$VM_NET_IP,hostname=$VM_NET_HOST"

  local forward
  forward=$(getUserPorts "$USER_PORTS")
  [ -n "$forward" ] && NET_OPTS+=",$forward"

  return 0
}

# Functions for second network interface
configureDHCP2() {
  # Create the necessary file structure for /dev/vhost-net
  if [ ! -c /dev/vhost-net ]; then
    if mknod /dev/vhost-net c 10 238; then
      chmod 660 /dev/vhost-net
    fi
  fi

  # Create a macvtap network for the VM guest
  { ip link add link "$VM_NET2_DEV" name "$VM_NET2_TAP" address "$VM_NET2_MAC" type macvtap mode bridge ; rc=$?; } || :

  if (( rc != 0 )); then
    error "Cannot create macvtap interface for second network. Please make sure that the network type is 'macvlan' and not 'ipvlan',"
    error "that your kernel is recent (>4) and supports it, and that the container has the NET_ADMIN capability set." && return 1
  fi

  while ! ip link set "$VM_NET2_TAP" up; do
    info "Waiting for MAC address $VM_NET2_MAC to become available..."
    sleep 2
  done

  local TAP_NR TAP_PATH MAJOR MINOR
  TAP_NR=$(</sys/class/net/"$VM_NET2_TAP"/ifindex)
  TAP_PATH="/dev/tap${TAP_NR}"

  # Create dev file (there is no udev in container: need to be done manually)
  IFS=: read -r MAJOR MINOR < <(cat /sys/devices/virtual/net/"$VM_NET2_TAP"/tap*/dev)
  (( MAJOR < 1)) && error "Cannot find: sys/devices/virtual/net/$VM_NET2_TAP" && return 1

  [[ ! -e "$TAP_PATH" ]] && [[ -e "/dev0/${TAP_PATH##*/}" ]] && ln -s "/dev0/${TAP_PATH##*/}" "$TAP_PATH"

  if [[ ! -e "$TAP_PATH" ]]; then
    { mknod "$TAP_PATH" c "$MAJOR" "$MINOR" ; rc=$?; } || :
    (( rc != 0 )) && error "Cannot mknod: $TAP_PATH ($rc)" && return 1
  fi

  { exec 31>>"$TAP_PATH"; rc=$?; } 2>/dev/null || :

  if (( rc != 0 )); then
    error "Cannot create TAP interface for second network ($rc). $ADD_ERR --device-cgroup-rule='c *:* rwm'" && return 1
  fi

  { exec 41>>/dev/vhost-net; rc=$?; } 2>/dev/null || :

  if (( rc != 0 )) && [[ "$DHCP2" == [Yy1]* ]]; then
    error "VHOST can not be found for second network ($rc). $ADD_ERR --device=/dev/vhost-net" && return 1
  fi

  NET2_OPTS="-netdev tap,id=hostnet1,vhost=on,vhostfd=41,fd=31"

  return 0
}

configureDNS2() {
  # Configure DNS for second interface
  DNSMASQ_OPTS+=" --dhcp-range=$VM_NET2_IP,$VM_NET2_IP --dhcp-host=$VM_NET2_MAC,,$VM_NET2_IP,$VM_NET2_HOST,infinite --dhcp-option=option:netmask,255.255.255.0"

  # Create lease file entry for second interface
  echo "0 $VM_NET2_MAC $VM_NET2_IP $VM_NET2_HOST 01:$VM_NET2_MAC" >> /var/lib/misc/dnsmasq.leases

  # Set DNS server and gateway for second interface
  DNSMASQ_OPTS+=" --dhcp-option=tag:$VM_NET2_MAC,option:dns-server,${VM_NET2_IP%.*}.1 --dhcp-option=tag:$VM_NET2_MAC,option:router,${VM_NET2_IP%.*}.1"

  # Add DNS entry for second interface
  DNSMASQ_OPTS+=" --address=/$VM_NET2_HOST.lan/${VM_NET2_IP%.*}.1"

  return 0
}

getUserPorts2() {
  # Always return empty string - no port forwarding on second interface
  echo ""
  return 0
}

configureUser2() {
  # Configure user-mode networking for second interface without port forwarding
  NET2_OPTS="-netdev user,id=hostnet1,host=${VM_NET2_IP%.*}.1,net=${VM_NET2_IP%.*}.0/24,dhcpstart=$VM_NET2_IP,hostname=$VM_NET2_HOST"
  
  # No port forwarding for second interface
  
  return 0
}

configureNAT2() {
  # Create the necessary file structure for /dev/net/tun
  if [ ! -c /dev/net/tun ]; then
    [ ! -d /dev/net ] && mkdir -m 755 /dev/net
    if mknod /dev/net/tun c 10 200; then
      chmod 666 /dev/net/tun
    fi
  fi

  if [ ! -c /dev/net/tun ]; then
    error "TUN device missing. $ADD_ERR --device /dev/net/tun --cap-add NET_ADMIN" && return 1
  fi

  # Check port forwarding flag
  if [[ $(< /proc/sys/net/ipv4/ip_forward) -eq 0 ]]; then
    { sysctl -w net.ipv4.ip_forward=1 > /dev/null; rc=$?; } || :
    if (( rc != 0 )) || [[ $(< /proc/sys/net/ipv4/ip_forward) -eq 0 ]]; then
      error "IP forwarding is disabled. $ADD_ERR --sysctl net.ipv4.ip_forward=1" && return 1
    fi
  fi

  # Create a bridge for second interface
  { ip link add dev dockerbridge2 type bridge ; rc=$?; } || :

  if (( rc != 0 )); then
    error "Failed to create bridge for second network. $ADD_ERR --cap-add NET_ADMIN" && return 1
  fi

  if ! ip address add "${VM_NET2_IP%.*}.1/24" broadcast "${VM_NET2_IP%.*}.255" dev dockerbridge2; then
    error "Failed to add IP address for second network!" && return 1
  fi

  while ! ip link set dockerbridge2 up; do
    info "Waiting for IP address to become available for second network..."
    sleep 2
  done

  # QEMU Works with taps, set tap to the bridge created
  if ! ip tuntap add dev "$VM_NET2_TAP" mode tap; then
    error "The 'tun' kernel module is not available for second network." && return 1
  fi

  while ! ip link set "$VM_NET2_TAP" up promisc on; do
    info "Waiting for TAP to become available for second network..."
    sleep 2
  done

  if ! ip link set dev "$VM_NET2_TAP" master dockerbridge2; then
    error "Failed to set IP link for second network!" && return 1
  fi

  # Add masquerading for outbound traffic only
  if ! iptables -t nat -A POSTROUTING -o "$VM_NET2_DEV" -j MASQUERADE; then
    error "The 'ip_tables' kernel module is not loaded for second network." && return 1
  fi

  # No PREROUTING rules for second interface - no inbound port forwarding

  NET2_OPTS="-netdev tap,id=hostnet1,ifname=$VM_NET2_TAP"

  if [ -c /dev/vhost-net ]; then
    { exec 41>>/dev/vhost-net; rc=$?; } 2>/dev/null || :
    (( rc == 0 )) && NET2_OPTS+=",vhost=on,vhostfd=41"
  fi

  NET2_OPTS+=",script=no,downscript=no"

  ! configureDNS2 && return 1

  return 0
}

configureNAT() {

  # Create the necessary file structure for /dev/net/tun
  if [ ! -c /dev/net/tun ]; then
    [ ! -d /dev/net ] && mkdir -m 755 /dev/net
    if mknod /dev/net/tun c 10 200; then
      chmod 666 /dev/net/tun
    fi
  fi

  if [ ! -c /dev/net/tun ]; then
    error "TUN device missing. $ADD_ERR --device /dev/net/tun --cap-add NET_ADMIN" && return 1
  fi

  # Check port forwarding flag
  if [[ $(< /proc/sys/net/ipv4/ip_forward) -eq 0 ]]; then
    { sysctl -w net.ipv4.ip_forward=1 > /dev/null; rc=$?; } || :
    if (( rc != 0 )) || [[ $(< /proc/sys/net/ipv4/ip_forward) -eq 0 ]]; then
      error "IP forwarding is disabled. $ADD_ERR --sysctl net.ipv4.ip_forward=1" && return 1
    fi
  fi

  local tables="The 'ip_tables' kernel module is not loaded. Try this command: sudo modprobe ip_tables iptable_nat"
  local tuntap="The 'tun' kernel module is not available. Try this command: 'sudo modprobe tun' or run the container with 'privileged: true'."

  # Create a bridge with a static IP for the VM guest

  { ip link add dev dockerbridge type bridge ; rc=$?; } || :

  if (( rc != 0 )); then
    error "Failed to create bridge. $ADD_ERR --cap-add NET_ADMIN" && return 1
  fi

  if ! ip address add "${VM_NET_IP%.*}.1/24" broadcast "${VM_NET_IP%.*}.255" dev dockerbridge; then
    error "Failed to add IP address!" && return 1
  fi

  while ! ip link set dockerbridge up; do
    info "Waiting for IP address to become available..."
    sleep 2
  done

  # QEMU Works with taps, set tap to the bridge created
  if ! ip tuntap add dev "$VM_NET_TAP" mode tap; then
    error "$tuntap" && return 1
  fi

  while ! ip link set "$VM_NET_TAP" up promisc on; do
    info "Waiting for TAP to become available..."
    sleep 2
  done

  if ! ip link set dev "$VM_NET_TAP" master dockerbridge; then
    error "Failed to set IP link!" && return 1
  fi

  # Add internet connection to the VM
  update-alternatives --set iptables /usr/sbin/iptables-legacy > /dev/null
  update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy > /dev/null

  exclude=$(getHostPorts "$HOST_PORTS")

  if ! iptables -t nat -A POSTROUTING -o "$VM_NET_DEV" -j MASQUERADE; then
    error "$tables" && return 1
  fi

  # shellcheck disable=SC2086
  if ! iptables -t nat -A PREROUTING -i "$VM_NET_DEV" -d "$IP" -p tcp${exclude} -j DNAT --to "$VM_NET_IP"; then
    error "Failed to configure IP tables!" && return 1
  fi

  if ! iptables -t nat -A PREROUTING -i "$VM_NET_DEV" -d "$IP" -p udp  -j DNAT --to "$VM_NET_IP"; then
    error "Failed to configure IP tables!" && return 1
  fi

  if (( KERNEL > 4 )); then
    # Hack for guest VMs complaining about "bad udp checksums in 5 packets"
    iptables -A POSTROUTING -t mangle -p udp --dport bootpc -j CHECKSUM --checksum-fill > /dev/null 2>&1 || true
  fi

  NET_OPTS="-netdev tap,id=hostnet0,ifname=$VM_NET_TAP"

  if [ -c /dev/vhost-net ]; then
    { exec 40>>/dev/vhost-net; rc=$?; } 2>/dev/null || :
    (( rc == 0 )) && NET_OPTS+=",vhost=on,vhostfd=40"
  fi

  NET_OPTS+=",script=no,downscript=no"

  ! configureDNS && return 1

  return 0
}

closeNetwork() {

  # Shutdown nginx
  nginx -s stop 2> /dev/null
  fWait "nginx"

  [[ "$NETWORK" == [Nn]* ]] && return 0

  # Cleanup first interface
  exec 30<&- || true
  exec 40<&- || true

  if [[ "$DHCP" == [Yy1]* ]]; then

    ip link set "$VM_NET_TAP" down || true
    ip link delete "$VM_NET_TAP" || true

  else

    local pid="/var/run/dnsmasq.pid"
    [ -s "$pid" ] && pKill "$(<"$pid")"

    [[ "${NETWORK,,}" == "user"* ]] && return 0

    ip link set "$VM_NET_TAP" down promisc off || true
    ip link delete "$VM_NET_TAP" || true

    ip link set dockerbridge down || true
    ip link delete dockerbridge || true

  fi

  # Cleanup second interface
  [[ "$NETWORK2" == [Nn]* ]] && return 0

  exec 31<&- || true
  exec 41<&- || true

  if [[ "$DHCP2" == [Yy1]* ]]; then

    ip link set "$VM_NET2_TAP" down || true
    ip link delete "$VM_NET2_TAP" || true

  else

    [[ "${NETWORK2,,}" == "user"* ]] && return 0

    ip link set "$VM_NET2_TAP" down promisc off || true
    ip link delete "$VM_NET2_TAP" || true

    ip link set dockerbridge2 down || true
    ip link delete dockerbridge2 || true

  fi

  return 0
}

checkOS() {

  local name
  local os=""
  name=$(uname -a)

  [[ "${name,,}" == *"darwin"* ]] && os="MacOS"
  [[ "${name,,}" == *"microsoft"* ]] && os="Windows"

  if [ -n "$os" ]; then
    warn "you are using Docker Desktop for $os which does not support macvlan, please revert to bridge networking!"
  fi

  return 0
}

getInfo() {

  if [ -z "$VM_NET_DEV" ]; then
    # Give Kubernetes priority over the default interface
    [ -d "/sys/class/net/net0" ] && VM_NET_DEV="net0"
    [ -d "/sys/class/net/net1" ] && VM_NET_DEV="net1"
    [ -d "/sys/class/net/net2" ] && VM_NET_DEV="net2"
    [ -d "/sys/class/net/net3" ] && VM_NET_DEV="net3"
    # Automaticly detect the default network interface
    [ -z "$VM_NET_DEV" ] && VM_NET_DEV=$(awk '$2 == 00000000 { print $1 }' /proc/net/route)
    [ -z "$VM_NET_DEV" ] && VM_NET_DEV="eth0"
  fi

  if [ ! -d "/sys/class/net/$VM_NET_DEV" ]; then
    error "Network interface '$VM_NET_DEV' does not exist inside the container!"
    error "$ADD_ERR -e \"VM_NET_DEV=NAME\" to specify another interface name." && exit 27
  fi

  if [ -z "$MAC" ]; then
    local file="$STORAGE/$PROCESS.mac"
    [ -s "$file" ] && MAC=$(<"$file")
    if [ -z "$MAC" ]; then
      # Generate MAC address based on Docker container ID in hostname
      MAC=$(echo "$HOST" | md5sum | sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02:\1:\2:\3:\4:\5/')
      echo "${MAC^^}" > "$file"
    fi
  fi

  VM_NET_MAC="${MAC^^}"
  VM_NET_MAC="${VM_NET_MAC//-/:}"

  if [[ ${#VM_NET_MAC} == 12 ]]; then
    m="$VM_NET_MAC"
    VM_NET_MAC="${m:0:2}:${m:2:2}:${m:4:2}:${m:6:2}:${m:8:2}:${m:10:2}"
  fi

  if [[ ${#VM_NET_MAC} != 17 ]]; then
    error "Invalid MAC address: '$VM_NET_MAC', should be 12 or 17 digits long!" && exit 28
  fi

  # Setup for second interface
  if [ -z "$VM_NET2_DEV" ]; then
    # Default to same device as first interface if not specified
    VM_NET2_DEV="$VM_NET_DEV"
  fi

  if [ -z "$MAC2" ]; then
    local file2="$STORAGE/$PROCESS.mac2"
    [ -s "$file2" ] && MAC2=$(<"$file2")
    if [ -z "$MAC2" ]; then
      # Generate a different MAC for second interface
      MAC2=$(echo "$HOST-2" | md5sum | sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02:\1:\2:\3:\4:\5/')
      echo "${MAC2^^}" > "$file2"
    fi
  fi

  VM_NET2_MAC="${MAC2^^}"
  VM_NET2_MAC="${VM_NET2_MAC//-/:}"

  if [[ ${#VM_NET2_MAC} == 12 ]]; then
    m="$VM_NET2_MAC"
    VM_NET2_MAC="${m:0:2}:${m:2:2}:${m:4:2}:${m:6:2}:${m:8:2}:${m:10:2}"
  fi

  if [[ ${#VM_NET2_MAC} != 17 && ${#VM_NET2_MAC} != 0 ]]; then
    error "Invalid MAC address for second interface: '$VM_NET2_MAC', should be 12 or 17 digits long!" && exit 28
  fi

  GATEWAY=$(ip route list dev "$VM_NET_DEV" | awk ' /^default/ {print $3}')
  IP=$(ip address show dev "$VM_NET_DEV" | grep inet | awk '/inet / { print $2 }' | cut -f1 -d/)

  return 0
}

# ######################################
#  Configure Second Network Interface
# ######################################

configureSecondNetwork() {
  if [[ "$NETWORK2" == [Nn]* ]]; then
    NET2_OPTS=""
    return 0
  fi

  html "Initializing second network interface (no port forwarding)..."

  if [[ "$DEBUG" == [Yy1]* ]]; then
    info "Second Interface - Host: $VM_NET2_HOST  IP: $VM_NET2_IP  Interface: $VM_NET2_DEV  MAC: $VM_NET2_MAC"
    echo
  fi

  if [[ "$DHCP2" == [Yy1]* ]]; then
    checkOS

    if [[ "$IP" == "172."* ]]; then
      warn "container IP starts with 172.* which is often a sign that you are not on a macvlan network (required for DHCP)!"
    fi

    # Configure for macvtap interface
    ! configureDHCP2 && warn "Failed to configure DHCP for second interface, disabling it" && NET2_OPTS="" && return 0

  else
    if [[ "$IP" != "172."* ]] && [[ "$IP" != "10.8"* ]] && [[ "$IP" != "10.9"* ]]; then
      checkOS
    fi

    if [[ "${NETWORK2,,}" != "user"* ]]; then
      # Configure for tap interface
      if ! configureNAT2; then
        NETWORK2="user"
        warn "falling back to usermode networking for second interface (slow)!"

        ip link set "$VM_NET2_TAP" down promisc off &> null || true
        ip link delete "$VM_NET2_TAP" &> null || true

        ip link set dockerbridge2 down &> null || true
        ip link delete dockerbridge2 &> null || true
      fi
    fi

    if [[ "${NETWORK2,,}" == "user"* ]]; then
      # Configure for usermode networking (slirp)
      ! configureUser2 && warn "Failed to configure user networking for second interface, disabling it" && NET2_OPTS="" && return 0
    fi
  fi

  # Only add the device if we have network options
  if [ -n "$NET2_OPTS" ]; then
    NET2_OPTS+=" -device virtio-net-pci,romfile=,netdev=hostnet1,mac=$VM_NET2_MAC,id=net1"
    html "Initialized second network interface successfully..."
  else
    html "Second network interface disabled or failed to initialize."
  fi

  return 0
}

# ######################################
#  Configure Network
# ######################################

if [[ "$NETWORK" == [Nn]* ]]; then
  NET_OPTS=""
  return 0
fi

getInfo
html "Initializing network..."

if [[ "$DEBUG" == [Yy1]* ]]; then
  info "Host: $HOST  IP: $IP  Gateway: $GATEWAY  Interface: $VM_NET_DEV  MAC: $VM_NET_MAC"
  [ -f /etc/resolv.conf ] && grep '^nameserver*' /etc/resolv.conf
  echo
fi

if [[ "$DHCP" == [Yy1]* ]]; then

  checkOS

  if [[ "$IP" == "172."* ]]; then
    warn "container IP starts with 172.* which is often a sign that you are not on a macvlan network (required for DHCP)!"
  fi

  # Configure for macvtap interface
  ! configureDHCP && exit 20

else

  if [[ "$IP" != "172."* ]] && [[ "$IP" != "10.8"* ]] && [[ "$IP" != "10.9"* ]]; then
    checkOS
  fi

  if [[ "${NETWORK,,}" != "user"* ]]; then

    # Configure for tap interface
    if ! configureNAT; then

      NETWORK="user"
      warn "falling back to usermode networking (slow)!"

      ip link set "$VM_NET_TAP" down promisc off &> null || true
      ip link delete "$VM_NET_TAP" &> null || true

      ip link set dockerbridge down &> null || true
      ip link delete dockerbridge &> null || true

    fi

  fi

  if [[ "${NETWORK,,}" == "user"* ]]; then

    # Configure for usermode networking (slirp)
    ! configureUser && exit 24

  fi

fi

NET_OPTS+=" -device virtio-net-pci,romfile=,netdev=hostnet0,mac=$VM_NET_MAC,id=net0"

html "Initialized network successfully..."

# Configure second network interface
configureSecondNetwork

# If second interface was configured successfully, add its options to the main NET_OPTS
if [ -n "$NET2_OPTS" ]; then
  NET_OPTS+=" $NET2_OPTS"
fi

return 0
