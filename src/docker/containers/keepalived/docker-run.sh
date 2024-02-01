docker run -d --name keepalived --restart=always \
  --cap-add=NET_ADMIN --cap-add=NET_BROADCAST --cap-add=NET_RAW --net=host \
  -e KEEPALIVED_UNICAST_PEERS="#PYTHON2BASH:['carl-nix-01', 'carl-nix-02', 'carl-nix-03', 'carl-nix-04', 'carl-nix-05']" \
  -e KEEPALIVED_VIRTUAL_IPS=10.0.255.18 \
  -e KEEPALIVED_PRIORITY=200 \
  osixia/keepalived:2.0.20