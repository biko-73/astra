#!/bin/sh

# =====================================
# SCRIPT : DOWNLOAD AND INSTALL astra #
# =================================================================================================
# Command: wget https://raw.githubusercontent.com/biko-73/astra/main/installers.sh -O - | /bin/sh #
# =================================================================================================

#config
plugin=astra-sm
version=0.2-r0
url=https://github.com/biko-73/astra/raw/main/astra-sm-0.2.tar.gz
url1=https://github.com/biko-73/astra/raw/main

ipk=astra-sm.ipk
package=/var/volatile/tmp/$plugin-$version.tar.gz
status='/var/lib/opkg/status'
install="opkg install --force-reinstall"

#download & install
echo "> Downloading $plugin-$version package  please wait ..."
sleep 3s

opkg install $plugin
if grep -q $plugin $status; then
echo "> $ipk installed successfully"
sleep 3s
else
cd /tmp
set -e
wget --show-progress "$url1/$ipk"
$install $ipk
set +e
cd ..
wait
rm -f /tmp/$ipk >/dev/null 2>&1
fi

wget -O $package --no-check-certificate $url
tar -xzf $package -C /
extract=$?
rm -rf package >/dev/null 2>&1

arch=$(uname -m)
case $arch in
aarch64)
wget -O /etc/astra/scripts/abertis https://github.com/biko-73/astra/raw/main/aarch/abertis
;;
mips)
wget -O /etc/astra/scripts/abertis https://github.com/biko-73/astra/raw/main/mips/abertis
;;
sh4)
wget -O /etc/astra/scripts/abertis https://github.com/biko-73/astra/raw/main/sh4/abertis
;;
arm)
wget -O /etc/astra/scripts/abertis https://github.com/biko-73/astra/raw/main/arm/abertis
;;
*) echo
esac

echo ''
if [ $extract -eq 0 ]; then
echo "> $plugin-$version package installed successfully"
echo "> Uploaded By Biko_73"
sleep 3s

else

echo "> $plugin-$version package installation failed"
sleep 3s
fi

wget -O /etc/enigma2/userbouquet.30w_abertis.tv https://raw.githubusercontent.com/biko-73/astra/main/userbouquet.30w_abertis.tv
sleep 2
echo '#SERVICE 1:7:1:0:0:0:0:0:0:0:FROM BOUQUET "userbouquet.30w_abertis.tv" ORDER BY bouquet' >> /etc/enigma2/bouquets.tv
echo ''
echo '**************************************************'
echo '**      Abertis Bouqet aded to your box         **'
echo '**************************************************'
echo ''

exit 0
