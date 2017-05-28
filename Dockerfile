FROM alpine:3.6

MAINTAINER Jiang Rensheng <13841495@qq.com>

# Install bash & nfs-utils
RUN apk --update upgrade && \
 apk add kmod mdadm lvm2 && \
 rm -rf /var/cache/apk/*

COPY ["/start-container.bash","/"]
RUN ["chmod","755","/start-container.bash"]

ENTRYPOINT ["/start-container.bash"]
