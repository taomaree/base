FROM ubuntu:18.04

ENV TZ=Asia/Shanghai LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive 

RUN apt-get update ; apt-get install -y --no-install-recommends ca-certificates curl wget apt-transport-https tzdata \
    dumb-init iproute2 iputils-ping telnet less vim-tiny unzip gosu fonts-dejavu-core \
    cron logrotate bsdiff; \
    groupmod -g 99 nogroup && groupadd -o -g 99 nobody  && usermod -u 99 -g 99 nobody && useradd -u 8080 -o java ; \
    mkdir -p ~/.pip && echo [global] > ~/.pip/pip.conf && echo "index-url = https://pypi.mirrors.ustc.edu.cn/simple" >> ~/.pip/pip.conf ;  \
    echo registry=http://npmreg.mirrors.ustc.edu.cn/ > ~/.npmrc ; \
    sed -i 's@ .*.ubuntu.com@ https://mirrors.ustc.edu.cn@g' /etc/apt/sources.list ;\
    apt-get clean  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
    
 
