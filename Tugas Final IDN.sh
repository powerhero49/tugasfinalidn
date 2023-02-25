#!/bin/bash
apt install apache2 -y #menginstall apache2
mkdir /etc/skel/public_html #membuat folder public_html di /etc/skel
touch /etc/skel/public_html/index.html #membuat file di folder public_html
a2enmod userdir #enable module user dir
for ((i=1; i<=50; i++))
do
adduser peserta$i --disabled-password --gecos peserta$i #menambahkan user
passwd peserta$i <<< "1"$'\n'"1" #menambahkan password
chmod 755 /home/peserta$i/public_html #merubah hak akses folder public_html
echo "<h1>Selamat datang di website "peserta$i" <h1>" >> /home/peserta$i/index.html #memasukkan script html di index.html
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/peserta$i.conf #copy file 000-default.conf untuk virtualhost
sed -i 's/#ServerName www.example.com/ServerName 'peserta$i'.lnxpeserta.33.id/g' /etc/apache2/sites-available/peserta$i.conf #merubah servername
sed -i 's\DocumentRoot /var/www/html\DocumentRoot /home/'peserta$i'\g' /etc/apache2/sites-available/peserta$i.conf #merubah documentroot
a2ensite peserta$i.conf #enable virtualhost
done
systemctl restart apache2 #restart service apache2
