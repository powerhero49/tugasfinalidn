#!/bin/bash
touch /etc/skel/index.html
for ((i=1; i<=50; i++))
do
adduser peserta$i --disabled-password --gecos peserta$i
passwd peserta$i <<< "1"$'\n'"1"
echo "<h1>Selamat datang di website "peserta$i" <h1>" >> /home/peserta$i/index.html
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/peserta$i.conf
sed -i 's/#ServerName www.example.com/ServerName 'peserta$i'.lnxpeserta.33.id/g' /etc/apache2/sites-available/peserta$i.conf
sed -i 's\DocumentRoot /var/www/html\DocumentRoot /home/'peserta$i'\g' /etc/apache2/sites-available/peserta$i.conf
a2ensite peserta$i.conf
done