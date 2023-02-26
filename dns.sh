apt install bind9 -y
cp /etc/bind/db.local /etc/bind/db.forward
cp /etc/bind/db.127 /etc/bind/db.reverse
sed -i 's/localhost/lnxpeserta-33.id/g' /etc/bind/db.forward
sed -i 's/localhost/lnxpeserta-33.id/g' /etc/bind/db.reverse
echo '@	IN	NS	lnxpeserta-33.id.' >> /etc/bind/db.forward
echo '@	IN	A	192.168.20.253' >> /etc/bind/db.forward
echo '@	IN	NS	lnxpeserta-33.id.' >> /etc/bind/db.reverse
echo '253	IN	PTR	lnxpeserta-33.id.' >> /etc/bind/db.reverse
for ((i=1; i<=50; i++))
do
echo 'peserta'$i'	IN	A	192.168.20.253' >> /etc/bind/db.forward
echo '253	IN	PTR	peserta'$i'.lnxpeserta-33.id.' >> /etc/bind/db.reverse
done
echo 'zone "lnxpeserta-33.id" {' >> /etc/bind/named.conf.local
echo '	type master;' >> /etc/bind/named.conf.local
echo '	file "/etc/bind/db.forward";' >> /etc/bind/named.conf.local
echo '};' >> /etc/bind/named.conf.local
echo -e '\n' >> /etc/bind/named.conf.local
echo 'zone "20.168.192.in-addr.arpa" {' >> /etc/bind/named.conf.local
echo '	type master;' >> /etc/bind/named.conf.local
echo '	file "/etc/bind/db.reverse";' >> /etc/bind/named.conf.local
echo '};' >> /etc/bind/named.conf.local
apt install resolvconf -y
echo 'nameserver 192.168.20.253' >> /etc/resolvconf/resolv.conf.d/head
systemctl restart bind9
systemctl restart resolvconf
systemctl status bind9
