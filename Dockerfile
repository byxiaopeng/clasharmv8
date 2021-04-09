FROM alpine
ENV VER=2021.03.10
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN set -ex \
        && apk update && apk upgrade \
        && apk add ca-certificates tzdata wget bash iptables  \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone
RUN if [ $(arch) == aarch64 ]; then     linux=linux-armv8;     wget -P /usr/bin https://github.com/Dreamacro/clash/releases/download/premium/clash-$linux-$VER.gz;     gunzip /usr/bin/clash-$linux-$VER.gz;     mv /usr/bin/clash-$linux-$VER /usr/bin/clash;     chmod +x /usr/bin/clash; fi
RUN if [ $(arch) == x86_64 ]; then     linux=linux-amd64;     wget -P /usr/bin https://github.com/Dreamacro/clash/releases/download/premium/clash-$linux-$VER.gz;     gunzip /usr/bin/clash-$linux-$VER.gz;     mv /usr/bin/clash-$linux-$VER /usr/bin/clash;     chmod +x /usr/bin/clash; fi
RUN wget -P /tmp https://raw.cnm.workers.dev/Hackl0us/GeoIP2-CN/release/Country.mmdb
RUN wget https://github.com/haishanh/yacd/releases/download/v0.2.15/yacd.tar.xz
VOLUME /root/.config/clash
EXPOSE 53 7890 7891 7892 7893 9090
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
