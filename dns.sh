apt install bind9 -y
cp /etc/bind/db.local /etc/bind/db.forward
cp /etc/bind/db.127 /etc/bind/db.reverse
sed -i 's/localhost/lnxpeserta-33.id/g' /etc/bind/db.forward
sed -i 's/localhost/lnxpeserta-33.id/g' /etc/bind/db.reverse
echo '@	IN	NS	lnxpeserta-33.id.' > /etc/bind/db.forward
echo '@	IN	A	192.168.20.253.' > /etc/bind/db.forward
echo '@	IN	NS	lnxpeserta-33.id.' > /etc/bind/db.reverse
echo '253	IN	PTR	lnxpeserta-33.id.' > /etc/bind/db.reverse
for ((i=1; i<=50; i++))
do
echo 'peserta'$i'	IN	A	192.168.20.253' > /etc/bind/db.forward
echo '253	IN	PTR	peserta'$i'.lnxpeserta-33.id.' > /etc/bind/db.reverse
done
echo 'zone "lnxpeserta-33.id" {'
echo '	type master;'
echo '	file "/etc/bind/db.forward"'
echo '};'
echo -e '\n'
echo 'zone "20.168.192.in-addr.arpa" {'
echo 'type master;'
echo 'file "/etc/bind/db.reverse"'
echo '};'
echo 'nameserver 192.168.20.253' > /etc/resolv.conf
systemctl restart bind9