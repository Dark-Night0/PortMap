#!/bin/bash

rd='\033[0;31m'          # Red
gr='\033[0;32m'        # Green
bu='\033[0;34m'         # Blue
pu='\033[0;35m'       # Purple
cy='\033[0;36m'         # Cyan

banner1() {

printf $bu"
                 ____   ___  ____ _____   __  __    _    ____  
                |  _ \ / _ \|  _ \_   _| |  \/  |  / \  |  _ \ 
                | |_) | | | | |_) || |   | |\/| | / _ \ | |_) |
$rd                |  __/| |_| |  _ < | |   | |  | |/ ___ \|  __/ 
                |_|    \___/|_| \_\|_|   |_|  |_/_/   \_\_|    
                                                               
"

}

banner2 (){

printf $rd'
                       ____             __  __  ___          
                      / __ \____  _____/ /_/  |/  /___ _____ 
                     / /_/ / __ \/ ___/ __/ /|_/ / __ `/ __ \
                    / ____/ /_/ / /  / /_/ /  / / /_/ / /_/ /
                   /_/    \____/_/   \__/_/  /_/\__,_/ .___/ 
                                                    /_/      
                                                              '
}

banner3 (){

printf "
$rd                                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                                |${bu} P${rd} | ${bu}O${rd} | ${bu}R${rd} | ${bu}T${rd} | ${bu}M${rd} | ${bu}A${rd} | ${bu}P${rd} | 
                                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+
"

}
help_h() {

printf $cy"
                                +-+-+-+-+-+-+-+
                                |P|O|R|T|M|A|P|
                                +-+-+-+-+-+-+-+
                                                                                                        "

	
echo -e $gr"\n [+]$bu Usage : portmap.sh [option] [argument]\n"
echo -e $gr" -h --help	$bu          # Display help menu"
echo -e $gr" -a --all	$bu          # Display all open ports and all connections"
echo -e $gr" -U --udp	$bu          # Display open ports UDP"
echo -e $gr" -T --tcp	$bu          # Display open ports TCP"
echo -e $gr" -k --kill <port,...>$bu     # colse port or more ports"
echo -e $gr" -o --open <port,...> l,f $bu# open port or more ports <l> live listen <f> open port in firewall machine"
echo -e $gr" -r --resolve	$bu          # resolve ip's domin's or name's"
echo -e '\n'          

}
Example(){

echo -e $rd' Examples:'
echo ' ========='
echo -e $bu"\tportmap.sh ${gr}-a -r \n\t\t ${cy}# Display all connections ${rd}and$cy resolved ip's"
echo -e $bu"\n\tportmap.sh ${gr} -T --resolve \n\t\t ${cy}# Display TCP connections ${rd}and ${cy}resolved ip's" 
echo -e $bu"\n\tportmap.sh ${gr} --udp -r \n\t\t${cy} # Display all connections UDP ${rd}and${cy} resolved ip's"
echo -e $bu"\n\tportmap.sh ${gr}-K 4444\n\t\t${cy} # colse this port"
echo -e $bu"\n\tportmap.sh ${gr}-K 5555,4040 \n\t\t${cy} # colse range ports"
echo -e $bu"\n\tportmap.sh ${gr} --open ${rd}l ${gr}4444${cy} \n\t\t # open live port"
echo -e $bu"\n\tportmap.sh ${gr}--open ${rd}f ${gr}4444,4040${cy} \n\t\t # open range live ports"
echo -e $bu"\n\tportmap.sh ${gr} --all \n\t\t ${cy}# Display all connections ${rd}and ${cy}all ports"

} 



if [ $(id -u) -eq 0 ] ;then
if [ -z $1 ] ;then
random=$(($RANDOM % 3+1))
banner$random
echo -e $gr"\n[+]$bu Usage : portmap.sh [option] [argument]"	
echo -e $rd "\tshow help menu ${gr}portmap${rd} -h , --help"

else

if [[ $1 = '-a' || $1 = '--all' ]] && [[ $2 = '-r' || $2 = '--resolve' ]] ;then
echo -e $rd "Please wait, trying to resolve ip's .....\n"
netstat -atul > file

num=$(cat file | wc -l)
num=$(expr $num - 2)
cat file | tail -$num > file1
num=$(expr $num - 1)
cat file1 | head -$num > file
awk '{print $1,$4,$5,$6}' file > file1
rm -r file
temp=' '
clear
for i in $(cat file1|tr ' ' '$'|grep -v 'udp6'|grep -v "tcp6");do

# The Different ip or getway (0.0.0.0)
if [ $(echo $i | cut -d ':' -f 1 | tr -d 'a-z -$') == "0.0.0.0" ];then

temp=$(echo $i | cut -d ':' -f 1 | tr -d 'a-z -$')

#source ip , #source port , #stype connections (tcp , udp) , #status connections

echo -e $cy"(${gr}SRC$cy) "$(echo $i|cut -d ':' -f 1|cut -d '$' -f2) \
$pu"   PORT(service): "${rd}$(echo $i|cut -d ':' -f 2|tr '$' ' '|cut -d ' ' -f 1) \
${gr}"("${bu}$(echo $i|cut -d '$' -f 1|tr 'a-z' 'A-Z')$gr")" \
$cy"(${pu}DST${cy})" $(echo $i|cut -d '$' -f 3|cut -d ':' -f 1) \
$pu"PORT(service): "$rd$(echo $i|cut -d '$' -f 3|cut -d ':' -f 2) \
${gr}$(echo $i|cut -d '$' -f 4 | tr -d '0-9/\-$') >> file2

elif [ $(echo $i | grep TIME_WAIT ) ] || [ $(echo $i | grep CLOSE_WAIT) ];then

echo -e $cy"(${gr}SRC$cy) "$(echo $i|cut -d ':' -f 1|tr -d 'a-z $') \
$pu" PORT(service): "${rd}$(echo $i|cut -d ':' -f 2|tr '$' ' '|cut -d ' ' -f 1) \
${gr}"("${bu}$(echo $i|cut -d '$' -f 1|tr 'a-z' 'A-Z')$gr")" \
$cy"(${pu}DST${cy})" $(echo $i|cut -d '$' -f 3|cut -d ':' -f 1) \
$pu"PORT(service): "$rd$(echo $i|cut -d '$' -f 3|cut -d ':' -f 2) \
${rd}$(echo $i|cut -d '$' -f 4 | tr -d '0-9/\-$')"_(CLOSING_PROGRESS)" >> file2	

else
# source ip , #source port , #stype connections (tcp , udp) , #status connections
# tcp-000.000.00.00:56074-000.000.00.00:443-ESTABLISHED

echo -e $cy"(${gr}SRC$cy) "$(echo $i|cut -d ':' -f 1|tr -d 'a-z $') \
$pu" PORT(service): "${rd}$(echo $i|cut -d ':' -f 2|tr '$' ' '|cut -d ' ' -f 1) \
${gr}"("${bu}$(echo $i|cut -d '$' -f 1|tr 'a-z' 'A-Z')$gr")" \
$cy"(${pu}DST${cy})" $(echo $i|cut -d '$' -f 3|cut -d ':' -f 1) \
$pu"PORT(service): "$rd$(echo $i|cut -d '$' -f 3|cut -d ':' -f 2) \
${gr}$(echo $i|cut -d '$' -f 4 | tr -d '0-9/\-$') >> file2
fi
done
clear
rm file1
cat file2 | column -t
rm file2
sleep 0.5
echo -e $rd"\n\nYou may encounter some problems in resolved ip's"

elif [[ $1 = '-T' || $1 = '--tcp' ]] && [[ $2 = '-r' || $2 = '--resolve' ]]  ;then
echo -e $rd "Please wait, trying to resolve ip's ....."
netstat -atul > file

num=$(cat file | wc -l)
num=$(expr $num - 2)
cat file | tail -$num > file1
num=$(expr $num - 1)
cat file1 | head -$num > file
awk '{print $1,$4,$5,$6}' file > file1
rm -r file
temp=' '
for i in $(cat file1|tr ' ' '$'|grep -v 'udp6'| grep -v 'tcp6'| grep -v "udp");do


if [ $(echo $i | grep TIME_WAIT ) ] || [ $(echo $i | grep CLOSE_WAIT) ];then
# echo $i > file2
 echo -e $cy"(${gr}SRC$cy) "$(echo $i|cut -d ':' -f 1|cut -d '$' -f 2) \
$pu" PORT: "${rd}$(echo $i|cut -d ':' -f 2|cut -d '$' -f 1) \
${gr}"("${bu}$(echo $i|cut -d '$' -f 1|tr 'a-z' 'A-Z')$gr")" \
$cy"(${pu}DST${cy})" $(echo $i|cut -d '$' -f 3|cut -d ':' -f 1) \
$pu"PORT "$rd$(echo $i|cut -d '$' -f 3|cut -d ':' -f 2) \
# ${rd}$(echo $i|cut -d '$' -f 4 | tr -d '0-9/\-')"_(CLOSING_PROGRESS)" >> file2	

else
# source ip , #source port , #stype connections (tcp , udp) , #status connections
# tcp-000.000.00.00:56074-000.000.00.00:443-ESTABLISHED
echo -e $cy"(${gr}SRC$cy) "$(echo $i|cut -d ':' -f 1|cut -d '$' -f 2) \
$pu" PORT: "${rd}$(echo $i|cut -d ':' -f 2|cut -d '$' -f 1) \
${gr}"("${bu}$(echo $i|cut -d '$' -f 1|tr 'a-z' 'A-Z')$gr")" \
$cy"(${pu}DST${cy})" $(echo $i|cut -d '$' -f 3|cut -d ':' -f 1) \
$pu"PORT "$rd$(echo $i|cut -d '$' -f 3|cut -d ':' -f 2) \
${rd}$(echo $i|cut -d '$' -f 4 | tr -d '0-9/\-') >> file2
fi
done
clear
rm file1
cat file2 | column -t
rm file2
sleep 0.5
echo -e $rd "\n\nYou may encounter some problems in resolved ip's"

elif [[ $1 = '-U' || $1 = '--udp' ]] && [[ $2 = '-r' || $2 = '--resolve' ]];then
echo -e $rd "Please wait, trying to resolve ip's ....."
netstat -atul > file

num=$(cat file | wc -l)
num=$(expr $num - 2)
cat file | tail -$num > file1
num=$(expr $num - 1)
cat file1 | head -$num > file
awk '{print $1,$4,$5,$6}' file > file1
rm -r file
temp=' '
for i in $(cat file1|tr ' ' '$'|grep -i "udp"|grep -v 'udp6'| grep -v 'tcp6'| grep -v tcp);do


if [ $(echo $i | grep TIME_WAIT ) ] || [ $(echo $i | grep CLOSE_WAIT) ];then
# echo $i > file2
 echo -e $cy"(${gr}SRC$cy) "$(echo $i|cut -d ':' -f 1|cut -d '$' -f 2) \
$pu" PORT: "${rd}$(echo $i|cut -d ':' -f 2|cut -d '$' -f 1) \
${gr}"("${bu}$(echo $i|cut -d '$' -f 1|tr 'a-z' 'A-Z')$gr")" \
$cy"(${pu}DST${cy})" $(echo $i|cut -d '$' -f 3|cut -d ':' -f 1) \
$pu"PORT "$rd$(echo $i|cut -d '$' -f 3|cut -d ':' -f 2) \
# ${rd}$(echo $i|cut -d '$' -f 4 | tr -d '0-9/\-')"_(CLOSING_PROGRESS)" >> file2	

else
# source ip , #source port , #stype connections (tcp , udp) , #status connections
# tcp-000.000.00.00:56074-000.000.00.00:443-ESTABLISHED
echo -e $cy"(${gr}SRC$cy) "$(echo $i|cut -d ':' -f 1|cut -d '$' -f 2) \
$pu" PORT: "${rd}$(echo $i|cut -d ':' -f 2|cut -d '$' -f 1) \
${gr}"("${bu}$(echo $i|cut -d '$' -f 1|tr 'a-z' 'A-Z')$gr")" \
$cy"(${pu}DST${cy})" $(echo $i|cut -d '$' -f 3|cut -d ':' -f 1) \
$pu"PORT "$rd$(echo $i|cut -d '$' -f 3|cut -d ':' -f 2) \
${rd}$(echo $i|cut -d '$' -f 4 | tr -d '0-9/\-') >> file2
fi
done
clear
rm file1
cat file2 | column -t
rm file2
sleep 0.5
echo -e $rd "\n\nYou may encounter some problems in resolved ip's"

elif [ $1 = '-a' ] || [ $1 = '--all' ]; then

netstat -antuplF > file

num=$(cat file | wc -l)
num=$(expr $num - 2)
cat file | tail -$num > file1
num=$(expr $num - 1)
cat file1 | head -$num > file
awk '{print $1,$4,$5,$6}' file > file1
rm -r file
temp=' '
for i in $(cat file1|tr ' ' '-'|grep -v 'udp6'| grep -v 'tcp6');do

# The Different ip or getway (0.0.0.0)
if [ $(echo $i | cut -d ':' -f 1 | tr -d 'a-z -') == "0.0.0.0" ];then

temp=$(echo $i | cut -d ':' -f 1 | tr -d 'a-z -')

#source ip , #source port , #stype connections (tcp , udp) , #status connections

echo -e "$cy(${gr}SRC$cy) "$(echo $i | cut -d ':' -f 1|tr -d 'a-z -') \
$pu"   PORT:${rd} $(echo $i | cut -d ':' -f 2 |tr '-' ' ' | cut -d ' ' -f 1) \
${gr}(${bu}$(echo $i | cut -d '-' -f 1|tr 'a-z' 'A-Z')$gr) \
$cy(${pu}DST${cy}) $(echo $i | cut -d '-' -f 3 | cut -d ':' -f 1) \
$pu"PORT"$rd $(echo $i | cut -d '-' -f 3 | cut -d ':' -f 2) \
${gr}$(echo $i |tr '-' ' '| cut -d ' ' -f 4|tr -d '0-9/\-' )" >> file2

elif [ $(echo $i | grep TIME_WAIT ) ];then

echo -e $cy"(${gr}SRC$cy) "$(echo $i|cut -d ':' -f 1|tr -d 'a-z -') \
$pu" PORT: "${rd}$(echo $i|cut -d ':' -f 2|tr '-' ' '|cut -d ' ' -f 1) \
${gr}"("${bu}$(echo $i|cut -d '-' -f 1|tr 'a-z' 'A-Z')$gr")" \
$cy"(${pu}DST${cy})" $(echo $i|cut -d '-' -f 3|cut -d ':' -f 1) \
$pu"PORT "$rd$(echo $i|cut -d '-' -f 3|cut -d ':' -f 2) \
${rd}$(echo $i|tr '-' ' '|cut -d ' ' -f 4 | tr -d '0-9/\-')"_(CLOSING_PROGRESS)" >> file2	

else
# source ip , #source port , #stype connections (tcp , udp) , #status connections
# tcp-000.000.00.00:56074-000.000.00.00:443-ESTABLISHED

echo -e $cy"(${gr}SRC$cy) "$(echo $i|cut -d ':' -f 1|tr -d 'a-z -') \
$pu" PORT: "${rd}$(echo $i|cut -d ':' -f 2|tr '-' ' '|cut -d ' ' -f 1) \
${gr}"("${bu}$(echo $i|cut -d '-' -f 1|tr 'a-z' 'A-Z')$gr")" \
$cy"(${pu}DST${cy})" $(echo $i|cut -d '-' -f 3|cut -d ':' -f 1) \
$pu"PORT "$rd$(echo $i|cut -d '-' -f 3|cut -d ':' -f 2) \
${gr}$(echo $i|tr '-' ' '|cut -d ' ' -f 4 | tr -d '0-9/\-') >> file2
fi
done
rm file1
cat file2 | column -t
rm file2
sleep 0.5
elif [ $1 = '-h' ] || [ $1 = '--help' ] ;then
help_h
Example

elif [ $1 = '-U' ] || [ $1 = '--udp' ];then
netstat -antuplF > file

num=$(cat file | wc -l)
num=$(expr $num - 2)
cat file | tail -$num > file1
num=$(expr $num - 1)
cat file1 | head -$num > file
awk '{print $1,$4,$5,$6}' file > file1
rm -r file
temp=' '
for i in $(cat file1|tr ' ' '-'|grep -v 'udp6'|grep -v "tcp6" | grep -v 'tcp');do

# The Different ip or getway (0.0.0.0)
if [ $(echo $i | cut -d ':' -f 1 | tr -d 'a-z -') == "0.0.0.0" ];then

temp=$(echo $i | cut -d ':' -f 1 | tr -d 'a-z -')

#source ip , #source port , #stype connections (tcp , udp) , #status connections

echo -e "$cy(${gr}SRC$cy) "$(echo $i | cut -d ':' -f 1|tr -d 'a-z -') \
$pu"   PORT:${rd} $(echo $i | cut -d ':' -f 2 |tr '-' ' ' | cut -d ' ' -f 1) \
${gr}(${bu}$(echo $i | cut -d '-' -f 1|tr 'a-z' 'A-Z')$gr) \
$cy(${pu}DST${cy}) $(echo $i | cut -d '-' -f 3 | cut -d ':' -f 1) \
$pu"PORT"$rd $(echo $i | cut -d '-' -f 3 | cut -d ':' -f 2) \
${gr}$(echo $i |tr '-' ' '| cut -d ' ' -f 4|tr -d '0-9/\-' )" >> file2

elif [ $(echo $i | grep TIME_WAIT ) ];then

echo -e $cy"(${gr}SRC$cy) "$(echo $i|cut -d ':' -f 1|tr -d 'a-z -') \
$pu" PORT: "${rd}$(echo $i|cut -d ':' -f 2|tr '-' ' '|cut -d ' ' -f 1) \
${gr}"("${bu}$(echo $i|cut -d '-' -f 1|tr 'a-z' 'A-Z')$gr")" \
$cy"(${pu}DST${cy})" $(echo $i|cut -d '-' -f 3|cut -d ':' -f 1) \
$pu"PORT "$rd$(echo $i|cut -d '-' -f 3|cut -d ':' -f 2) \
${rd}$(echo $i|tr '-' ' '|cut -d ' ' -f 4 | tr -d '0-9/\-')"_(CLOSING_PROGRESS)" >> file2	

else
# source ip , #source port , #stype connections (tcp , udp) , #status connections
# tcp-000.000.00.00:56074-000.000.00.00:443-ESTABLISHED

echo -e $cy"(${gr}SRC$cy) "$(echo $i|cut -d ':' -f 1|tr -d 'a-z -') \
$pu" PORT: "${rd}$(echo $i|cut -d ':' -f 2|tr '-' ' '|cut -d ' ' -f 1) \
${gr}"("${bu}$(echo $i|cut -d '-' -f 1|tr 'a-z' 'A-Z')$gr")" \
$cy"(${pu}DST${cy})" $(echo $i|cut -d '-' -f 3|cut -d ':' -f 1) \
$pu"PORT "$rd$(echo $i|cut -d '-' -f 3|cut -d ':' -f 2) \
${gr}$(echo $i|tr '-' ' '|cut -d ' ' -f 4 | tr -d '0-9/\-') >> file2
fi
done
rm file1
cat file2 | column -t
rm file2
sleep 0.5
elif [ $1 = '-T' ]||[ $1 = '--tcp' ];then
netstat -antuplF > file

num=$(cat file | wc -l)
num=$(expr $num - 2)
cat file | tail -$num > file1
num=$(expr $num - 1)
cat file1 | head -$num > file
awk '{print $1,$4,$5,$6}' file > file1
rm -r file
temp=' '
for i in $(cat file1|tr ' ' '-'|grep -v 'udp6'|grep -v "tcp6" | grep -v "udp");do

# The Different ip or getway (0.0.0.0)
if [ $(echo $i | cut -d ':' -f 1 | tr -d 'a-z -') == "0.0.0.0" ];then

temp=$(echo $i | cut -d ':' -f 1 | tr -d 'a-z -')

#source ip , #source port , #stype connections (tcp , udp) , #status connections

echo -e "$cy(${gr}SRC$cy) "$(echo $i | cut -d ':' -f 1|tr -d 'a-z -') \
$pu"   PORT:${rd} $(echo $i | cut -d ':' -f 2 |tr '-' ' ' | cut -d ' ' -f 1) \
${gr}(${bu}$(echo $i | cut -d '-' -f 1|tr 'a-z' 'A-Z')$gr) \
$cy(${pu}DST${cy}) $(echo $i | cut -d '-' -f 3 | cut -d ':' -f 1) \
$pu"PORT"$rd $(echo $i | cut -d '-' -f 3 | cut -d ':' -f 2) \
${gr}$(echo $i |tr '-' ' '| cut -d ' ' -f 4|tr -d '0-9/\-' )" >> file2

elif [ $(echo $i | grep TIME_WAIT ) ];then

echo -e $cy"(${gr}SRC$cy) "$(echo $i|cut -d ':' -f 1|tr -d 'a-z -') \
$pu" PORT: "${rd}$(echo $i|cut -d ':' -f 2|tr '-' ' '|cut -d ' ' -f 1) \
${gr}"("${bu}$(echo $i|cut -d '-' -f 1|tr 'a-z' 'A-Z')$gr")" \
$cy"(${pu}DST${cy})" $(echo $i|cut -d '-' -f 3|cut -d ':' -f 1) \
$pu"PORT "$rd$(echo $i|cut -d '-' -f 3|cut -d ':' -f 2) \
${rd}$(echo $i|tr '-' ' '|cut -d ' ' -f 4 | tr -d '0-9/\-')"_(CLOSING_PROGRESS)" >> file2	

else
# source ip , #source port , #stype connections (tcp , udp) , #status connections
# tcp-000.000.00.00:56074-000.000.00.00:443-ESTABLISHED

echo -e $cy"(${gr}SRC$cy) "$(echo $i|cut -d ':' -f 1|tr -d 'a-z -') \
$pu" PORT: "${rd}$(echo $i|cut -d ':' -f 2|tr '-' ' '|cut -d ' ' -f 1) \
${gr}"("${bu}$(echo $i|cut -d '-' -f 1|tr 'a-z' 'A-Z')$gr")" \
$cy"(${pu}DST${cy})" $(echo $i|cut -d '-' -f 3|cut -d ':' -f 1) \
$pu"PORT "$rd$(echo $i|cut -d '-' -f 3|cut -d ':' -f 2) \
${gr}$(echo $i|tr '-' ' '|cut -d ' ' -f 4 | tr -d '0-9/\-') >> file2
fi
done
rm file1
cat file2 | column -t
rm file2
sleep 0.5 
elif [ $1 = '-k' ]||[ $1 = '--kill' ];then

kilport=$(echo $2 | tr ',' ' ')
for i in $(echo $kilport) ;do
kill -9 $(lsof -t -i:$i)
clear
done
echo -e $gr" Done ^_^ , colse port(s) $rd $kilport"

elif [ $1 = '-o' ] || [ $1 = '--open'  ]&& [ $2 = 'f' ];then
openport=$(echo $3 | tr ',' ' ')
for i in $(echo $openport);do
# sudo ufw allow $i
sudo iptables -A INPUT -p tcp --dport $i -j ACCEPT
clear
done
echo -e $gr" Done *_* .. port(s) ${rd} $openport $gr Now Opening in your firewall"
elif [ $1 = '-o' ] || [ $1 = '--open'  ]&& [ $2 = 'l' ];then
openport=$(echo $3 | tr ',' ' ')
sudo ncat -lvp $openport

sleep 0.5
clear
echo -e $gr" Done *_* .. You were listening on port $openport with a netcat tool "
else
echo -e $rd " \nincorrect argument ..! \n\n"
sleep 2
help_h
echo -e $rd" If you think that the options are correct, then there are priorities for the options ..!"
fi
fi
else

	echo -e $rd 'Runing The Script as a root user !!'
	exit
fi
