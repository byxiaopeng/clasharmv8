#!/bin/bash
# 开启转发
sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
sysctl -p
iptables -t nat -N CLASHRULE

iptables -t nat -A CLASHRULE -d 127.0.0.0/8 -j RETURN
iptables -t nat -A CLASHRULE -d 192.168.0.0/16 -j RETURN
iptables -t nat -A CLASHRULE -p tcp -j REDIRECT --to-ports 7892

# 在 PREROUTING 链前插入 CLASHRULE 链,使其生效
iptables -t nat -A PREROUTING -p tcp -j CLASHRULE
#启动ssh
service ssh restart
#echo -e "nameserver 192.168.50.53" > /etc/resolv.conf
#pm2-runtime /clash/clash-linux-armv8
ip addr
nohup /Ad/AdGuardHome >AdGuardHome.txt 2>&1 &
/clash/clash-linux-armv8


