echo "building docker image..."
docker build -t YeezyWhy/ovpnimage .
echo "done!"

echo "run image with defaults? (y/n):"
read answer

if [[$answer -eq "n" || $answer -eq "N"]]; then
    echo "enter container name (default: dockovpn):"
    read container_name
    if [[ -z $container_name ]] then
        $container_name = "dockovpn"
    fi
    echo "enter tunnel port (default: 1194):"
    read tun_port
    if [[ -z $tun_port ]] then
        $tun_port = 1194
    fi
    echo "enter config download page port (default: 80):"
    read conf_port
    if [[ -z $conf_port ]] then
        $conf_port = 80
    fi
    echo "enter host addr (default: $(curl -s https://api.ipify.org)):"
    read host_addr
    if [[ -z $host_addr ]] then
        $host_addr = $(curl -s https://api.ipify.org)
    fi
    docker run -d --name $container_name --cap-add=NET_ADMIN \
    -p $tun_port:$tun_port/udp -p $conf_port:8080/tcp \
    -e HOST_CONF_PORT=$conf_port \
    -e HOST_TUN_PORT=$tun_port \
    -e HOST_ADDR=$host_addr \
    YeezyWhy/ovpnimage
else
    echo "enter container name (default: dockovpn):"
    read container_name
    if [[ -z $container_name ]] then
        $container_name = "dockovpn"
    fi
    echo "enter host addr (default: $(curl -s https://api.ipify.org)):"
    read host_addr
    if [[ -z $host_addr ]] then
        $host_addr = $(curl -s https://api.ipify.org)
    fi
    docker run -d --name $container_name --cap-add=NET_ADMIN \
    -p 1194:1194/udp -p 80:8080/tcp \
    -e HOST_ADDR=$host_addr \
    YeezyWhy/ovpnimage
fi