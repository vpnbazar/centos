#!/bin/bash

#set localtime
ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime

# installing 
wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -Uvh epel-release-6-8.noarch.rpm
yum repolist
yum --enablerepo=epel info fail2ban
yum --enablerepo=epel install fail2ban
yum install unzip -y
yum update -y
rm /etc/sysctl.conf
yum install vixie-cron crontabs httpd git zip unzip epel-release -y
yum install php php-pdo php-mysqli php-mysql php-gd php-mbstring.x86_64 -y
yum install php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap curl curl-devel -y

# get file
wget -O /etc/openvpn.zip "https://raw.githubusercontent.com/kylegwapse/centos/master/premium.zip"
cd /etc/
unzip openvpn.zip
cd
wget -O /var/var.zip "https://raw.githubusercontent.com/kylegwapse/centos/master/var.zip"
cd /var/
unzip var.zip
cd

sysctl -p
yum install mysql-server  dos2unix  nano squid openvpn easy-rsa httpd -y
cd /etc/openvpn/login
dos2unix auth_vpn
chmod 755 auth_vpn
cd /etc/openvpn/
chmod 755 disconnect.sh

echo "acl Denied_ports port 1195-65535
http_access deny Denied_ports
acl to_vpn dst `curl ipinfo.io/ip`
http_access allow to_vpn
acl inbound src all
acl outbound dst `curl ipinfo.io/ip`/32
http_access allow inbound outbound
http_access deny all
http_port 8989 transparent
http_port 8000 transparent
http_port 8888 transparent
http_port 110 transparent
http_port 8989 transparent
http_port 2525 transparent
http_port 464 transparent
http_port 1194 transparent
visible_hostname TymlexVPN
cache_mgr dheluxeDEV"| sudo tee /etc/squid/squid.conf	


sudo /sbin/iptables -L -nsudo /sbin/iptables -L -n
 sudo /sbin/iptables -L -n
 /sbin/iptables -L -n
 /etc/init.d/iptables save
   /etc/init.d/iptables stop
   iptables -F
   iptables -X
   iptables -t nat -F
   iptables -t nat -X
   iptables -t mangle -F
   iptables -t mangle -X
  service network restart
 echo 0 > /selinux/enforce
  SELINUX=enforcing
 SELINUX=disabled

iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o venet0 -j SNAT --to-source `curl ipinfo.io/ip`
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT --to-source `curl ipinfo.io/ip`
iptables -A LOGDROP -j DROP
cd
cd

service iptables save
service iptables restart
echo 0 > /selinux/enforce
  SELINUX=enforcing
 SELINUX=disabled
service openvpn restart
service squid restart
chmod 777 /var/www/html/stat/status.log.txt
cd	

#install Stunnel
yum install stunnel -y 
wget -O /etc/stunnel/stunnel.conf "https://raw.githubusercontent.com/kylegwapse/centos/master/stunnel.conf"
wget -O /etc/stunnel/stunnel.pem "https://raw.githubusercontent.com/kylegwapse/centos/master/stunnel.pem"
chown nobody:nobody /var/run/stunnel
wget -O /etc/rc.d/init.d/stunnel "https://raw.githubusercontent.com/kylegwapse/centos/master/stunnel"
chmod 744 /etc/rc.d/init.d/stunnel
SEXE=/usr/bin/stunnel
SEXE=/usr/sbin/stunnel
 chmod +x /etc/rc.d/init.d/stunnel
 /sbin/chkconfig --add stunnel

#install Privoxy
MYIP=$(curl -s http://whatismyip.akamai.com/)
yum install privoxy -y

rm -f /etc/privoxy/config
cat>>/etc/privoxy/config<<EOF
user-manual /usr/share/doc/privoxy/user-manual
confdir /etc/privoxy
logdir /var/log/privoxy
filterfile default.filter
logfile logfile
listen-address  0.0.0.0:8008
listen-address  0.0.0.0:8080
listen-address  0.0.0.0:8118
toggle  1
enable-remote-toggle  0
enable-remote-http-toggle  0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
enable-proxy-authentication-forwarding 1
forwarded-connect-retries  1
accept-intercepted-requests 1
allow-cgi-request-crunching 1
split-large-forms 0
keep-alive-timeout 5
tolerate-pipelining 1
socket-timeout 300
permit-access 0.0.0.0/0 $MYIP
EOF

#check status
service privoxy status
netstat -lntp | grep privoxy

#Install Dropbear
rpm -Uvh http://ftp-stud.hs-esslingen.de/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum install dropbear -y
wget -O /etc/init.d/dropbear "https://raw.githubusercontent.com/kylegwapse/centos/master/dropbear"

#get connection
crontab -r
mkdir /usr/sbin/kpn
wget -O /usr/sbin/kpn/connection.php "https://raw.githubusercontent.com/kylegwapse/centos/master/premiumconnection.sh"
echo "*/5 * * * * /usr/bin/php /usr/sbin/kpn/connection.php >/dev/null 2>&1
*/5 * * * * /bin/bash /usr/sbin/kpn/active.sh >/dev/null 2>&1
*/5 * * * * /bin/bash /usr/sbin/kpn/inactive.sh >/dev/null 2>&1" | tee -a /var/spool/cron/root

#start service
/sbin/chkconfig crond on
/sbin/service crond start
/etc/init.d/crond start
service crond restart
service sshd restart
service httpd restart
service stunnel start
service privoxy restart
service dropbear start
service openvpn restart
service squid start


echo 'Done setup you can now close the terminal window and exit the app!';
echo '#############################################
#      CENTOS 6 Setup openvpn with ssl/ssh  #
#         Authentication file system        #
#       Setup by: TymlexVPN DEV   #
#      Modified by: TymlexVPN DEV #
#     Do Not Change This To Avoid Error     #
#############################################';

