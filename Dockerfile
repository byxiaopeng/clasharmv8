FROM arm64v8/debian
#更新源
RUN apt-get -y update && apt-get -y upgrade
#安装ssh
RUN apt install -y wget openssh-server iptables curl unzip ipset dnsutils
ENV VER=2020.11.20
#同步系统时间
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN echo root:123456789 |chpasswd root

RUN wget  -P /usr/bin https://github.com/Dreamacro/clash/releases/download/premium/clash-linux-armv8-$VER.gz
RUN gunzip /usr/bin/clash-linux-armv8-$VER.gz
RUN mv /usr/bin/clash-linux-armv8-$VER /usr/bin/clash
RUN chmod +x /usr/bin/clash

VOLUME /root/.config/clash

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
EXPOSE 53 7890 7891 7892 7893 9090
