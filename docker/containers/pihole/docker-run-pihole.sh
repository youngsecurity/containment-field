#
##################################################
### Disable systemd-resolved DNS stub resolver ###
##################################################
# When using a Docker Bridged network type, modern releases of Ubuntu (17.10+) and Fedora (33+) include systemd-resolved which uses a caching DNS stub resolver and prevents pi-hole from listening on port 53
# The stub resolver should be disabled with: https://github.com/pi-hole/docker-pi-hole#installing-on-ubuntu-or-fedora
sudo sed -r -i.orig 's/#?DNSStubListener=yes/DNSStubListener=no/g' /etc/systemd/resolved.conf
sudo sh -c 'rm /etc/resolv.conf && ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf'
systemctl restart systemd-resolved

# Delete existing pihole
docker rm -f pihole

# Setup pihole using specific tag, because the :latest tag does not always pull down the latest version
docker run -itd -p 81:80 -p 53:53/tcp -p 53:53/udp --name=pihole --net=Transit --ip=10.10.10.5 --restart=unless-stopped -h pihole -e TZ=America/New_York -v etc-pihole:/etc/pihole/ -v etc-dnsmasq.d:/etc/dnsmasq.d/ pihole/pihole:2023.02.2