# docker-nfs-server

## to start
    docker run -it --privileged --name mdadm -v /dev:/dev alpine /bin/sh

## volumes
You will need to provide the container with the volume(s) that you want to expose via nfs
    
    -v <local path>:<path in container>

## environment variables
You will need to provide at the following 3 environment variables to configure the nfs exports:
* NFS_EXPORT_DIR_1
* NFS_EXPORT_DOMAIN_1
* NFS_EXPORT_OPTIONS_1

When the container is started, the environment variables are parsed and the following output is created in **/etc/exports** file:

    NFS_EXPORT_DIR_1 NFS_EXPORT_DOMAIN_1(NFS_EXPORT_OPTIONS_1)
for the example given the following line in **/etc/exports** would be created:

    /nfs *(ro,insecure,no_subtree_check, no_root_squash, fsid=1)

To define multiple exports, just increment the index on the environment variables

## build command
    docker build -t fuzzle/docker-nfs-server:v1 .

## inspect running container
docker exec -ti CONTAINER bash

## mounting the nfs share from another host
mount -v -t nfs -o ro,nfsvers=3,nolock,proto=udp,port=2049 <ip_address_docker_host>:/nfs /mnt/scratch

## Todo
* There seems to be a bug on systems with ipv6 disabled kernels/configs:
[have a look at the mailing list](http://www.spinics.net/lists/linux-nfs/msg53046.html)
 * should be fixed with nfs-utils-1.3.4
* eliminate --privileged mode, have a look ...
 * [here](http://linux.die.net/man/7/capabilities)
 * and [here](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities)
* Setup automated build
 * [Automated Builds](https://docs.docker.com/docker-hub/builds/)
