## Building & Running

### Building docker image

```bash
docker build -t username/imagename .
```

### Running with custom settings

```bash
docker run -d --name $container_name --cap-add=NET_ADMIN \
    -p 1194:1194/udp -p 80:8080/tcp \
    -e HOST_CONF_PORT=80 \
    -e HOST_TUN_PORT=1194 \
    -e HOST_ADDR=62.165.14.55 \
    -e HOST_TUN_MTU=1400
    username/imagename
```


### Running with defaults

```bash
docker run -d --name $container_name --cap-add=NET_ADMIN \
    -p 1194:1194/udp -p 80:8080/tcp \
    -e HOST_ADDR=62.165.14.55 \
    username/imagename
```