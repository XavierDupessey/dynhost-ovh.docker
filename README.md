# dynhost-ovh.docker

17MB docker image (based on Alpine) for OVH dynhost service.
The IP change verification interval is set to 15 minutes.


## Build

```
docker build --no-cache -t dynhost-ovh .
```


## Run

```
docker run \
    --name dynhost-ovh.my-domain \
    --restart=always \
    --detach \
    -e DYNHOST_DOMAIN_NAME=my-domain \
    -e DYNHOST_LOGIN=my-dynhost-user-set-on-ovh-manager \
    -e DYNHOST_PASSWORD=my-dynhost-password-set-on-ovh-manager \
    dynhost-ovh
```
