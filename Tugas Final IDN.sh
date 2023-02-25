#!/bin/bash
apt install apache2 -y
mkdir /etc/skel/public_html
touch /etc/skel/public_html/index.html
a2enmod userdir
for ((i=1; i<=50; i++))
do
adduser peserta$i --disabled-password --gecos peserta$i
passwd peserta$i <<< "1"$'\n'"1"
chmod 755 /home/peserta$i/public_html
echo "<h1>Selamat datang di website "peserta$i" <h1>" >> /home/peserta$i/index.html
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/peserta$i.conf
sed -i 's/#ServerName www.example.com/ServerName 'peserta$i'.lnxpeserta.33.id/g' /etc/apache2/sites-available/peserta$i.conf
sed -i 's\DocumentRoot /var/www/html\DocumentRoot /home/'peserta$i'\g' /etc/apache2/sites-available/peserta$i.conf
a2ensite peserta$i.conf
done
systemctl restart apache2
