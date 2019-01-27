FROM ubuntu:18.04

ENV TZ=Asia/Shanghai LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive 

RUN apt-get update ; apt-get install -y --no-install-recommends ca-certificates curl wget apt-transport-https tzdata \
    dumb-init iproute2 iputils-ping iputils-arping telnet less vim-tiny unzip gosu fonts-dejavu-core \
    net-tools socat netcat traceroute jq mtr-tiny \
    cron logrotate runit rsyslog-kafka gosu bsdiff; \
    groupmod -g 99 nogroup && groupadd -o -g 99 nobody  && usermod -u 99 -g 99 nobody && useradd -u 8080 -o java ; \
    mkdir -p ~/.pip && echo [global] > ~/.pip/pip.conf && echo "index-url = https://pypi.mirrors.ustc.edu.cn/simple" >> ~/.pip/pip.conf ;  \
    echo registry=http://npmreg.mirrors.ustc.edu.cn/ > ~/.npmrc ; \
    sed -i 's@ .*.ubuntu.com@ https://mirrors.ustc.edu.cn@g' /etc/apt/sources.list ;\
    sed -i '/session    required     pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/cron ;\
    sed -i 's/^module(load="imklog"/#module(load="imklog"/g' /etc/rsyslog.conf ;\
    mkdir -p /etc/service/cron /etc/service/logrotate /etc/service/syslog ;\
    bash -c 'echo -e "#!/bin/bash\nexec /usr/sbin/rsyslogd -n" > /etc/service/syslog/run' ;\
    bash -c 'echo -e "#!/bin/bash\nexec /usr/sbin/cron -f" > /etc/service/cron/run' ;\
    chmod 755 /etc/service/cron/run /etc/service/syslog/run ;\
    apt-get clean  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# ENTRYPOINT ["runsvdir", "/etc/service"]
# ENTRYPOINT ["/usr/bin/dumb-init", "--"]

