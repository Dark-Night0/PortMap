#!/bin/bash
rd='\033[0;31m'          # Red
gr='\033[0;32m'        # Green
bu='\033[0;34m'         # Blue

if [ $(id -u) -eq 0 ];then
sudo chmod +x portmap.sh
printf $rd"

     /_/_/_/      _/_/    _/_/_/    _/_/_/_/_/     $bu /_/      _/    _/_/    _/_/_/    
    /_$gr/    _/  _/    _/  _/    _/      _/        $rd  /_/_/  _/_/  _/    _/  _/    _/   
  $bu /_/_/_/    _/    _/  _/_/_/        _/     $gr     /_/  _/  _/  _/_/_/_/  _/_/_/      
  $rd/_/        _/    _/  _/    _/      _/          $gr/_/      _/  _/    _/  _/           
 $bu/_/          _/_/    _/    _/      _/        $rd  /_/      _/  _/    _/  _/            

"
printf "
$rd	What is Your Operating System ?

$gr	1) Kali Linux , (Other Distribute Linux )

	2) Termux

	3) exit
"
read -p ">> " check

if [ $check -eq 1 ];then

sudo apt update
sudo apt install net-tools -y
sudo apt install gawk -y
sudo apt install ufw -y
sudo apt install ncat -y

clear

if [ $(which netstat | cut -d '/' -f 4) = 'netstat' ];then
	echo -e "$gr\n[+] $bu netstat .... $gr[ found ]"|column -t
sleep 1
else
	echo -e "$rd \n[-] $bu netstat .... $rd[ not found ]"|column -t
sleep 1
fi

if [ $(which ncat |cut -d '/' -f 4) = 'ncat' ];then
	echo -e "$gr\n[+] $bu netcat .... $gr[ found ]"|column -t
sleep 1
else
	echo -e "$rd \n[-] $bu netcat .... $rd[ not found ]"|column -t
sleep 1
fi

if [ $(which iptables | cut -d '/' -f 4) = 'iptables' ];then

	echo -e "$gr\n[+] $bu iptabels .... $gr[ found ]"|column -t
sleep 1
else
	echo -e "$rd \n[-] $bu iptabels .... $rd[ not found ]"|column -t
sleep 1
fi

if [ $(which awk | cut -d '/' -f 4) = 'awk' ];then
	echo -e "$gr\n[+] $bu awk .... $gr[ found ]"|column -t
sleep 1
else
	echo -e "$rd \n[-] $bu awk .... $rd[ not found ]"|column -t
sleep 1
fi
echo -e $gr "\n\n Done .."

elif [ $check = 2 ] ;then
pkg update
pkg install net-tools -y
apt install iptabels -y
apt install ncat -y


clear

if [ $(which netstat | cut -d '/' -f 4) = 'netstat' ];then
	echo -e "$gr\n[+] $bu netstat .... $gr[ found ]"|column -t
sleep 1
else
	echo -e "$rd \n[-] $bu netstat .... $rd[ not found ]"|column -t
sleep 1
fi

if [ $(which ncat |cut -d '/' -f 4) = 'ncat' ];then
	echo -e "$gr\n[+] $bu netcat .... $gr[ found ]"|column -t
sleep 1
else
	echo -e "$rd \n[-] $bu netcat .... $rd[ not found ]"|column -t
sleep 1
fi

if [ $(which iptables | cut -d '/' -f 4) = 'iptables' ];then

	echo -e "$gr\n[+] $bu iptabels .... $gr[ found ]"|column -t
sleep 1
else
	echo -e "$rd \n[-] $bu iptabels .... $rd[ not found ]"|column -t
sleep 1
fi

if [ $(which awk | cut -d '/' -f 4) = 'awk' ];then
	echo -e "$gr\n[+] $bu awk .... $gr[ found ]"|column -t
sleep 1
else
	echo -e "$rd \n[-] $bu awk .... $rd[ not found ]"|column -t
sleep 1
fi
echo -e $gr "\n\nDone .."

elif [ $check -eq 3 ] ;then

echo -e $rd"\tBay ..! "
	exit
else 
	echo -e $rd" Sorry , No Support This OS Now .."
fi
else
	echo -e $rd "Run the script as a root ... ! "
fi

