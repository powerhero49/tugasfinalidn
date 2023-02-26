#!/bin/bash
apt install apache2 -y
a2enmod userdir
for ((i=1; i<=50; i++))
do
adduser peserta$i --disabled-password --gecos peserta$i
passwd peserta$i <<< "1"$'\n'"1"
mkdir /home/peserta$i/public_html
touch /home/peserta$i/public_html/index.html
chmod 755 /home/peserta$i/public_html
echo "<h1>Selamat datang di website "peserta$i" <h1>" >> /home/peserta$i/public_html/index.html
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/peserta$i.conf
sed -i 's/#ServerName www.example.com/ServerName 'peserta$i'.lnxpeserta-33.id/g' /etc/apache2/sites-available/peserta$i.conf
sed -i 's\DocumentRoot /var/www/html\DocumentRoot /home/'peserta$i'/public_html\g' /etc/apache2/sites-available/peserta$i.conf
a2ensite peserta$i.conf
done
echo '<Directory /home/>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
</Directory>' >> /etc/apache2/apache2.conf
systemctl restart apache2
systemctl status apache2
