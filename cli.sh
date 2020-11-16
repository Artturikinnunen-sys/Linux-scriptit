#!/bin/bash

chmod 645 ~/.ssh/config
i="0"
re='^[1-5]+$'

while [ $i -lt 1 ] #Päävalikon while loop alkaa tästä
do
printf "Hello, welcome custom putty. Please select number\n (1) Print SSH profiles\n (2) Connect SSH profile\n (3) Add SSH profile\n (4) FIX: Certificate\n (5) Quit\n\n"  
read -p "Choose (1,2,3,4,5): " valinta #Pyydetään valinta käyttäjältä

if ! [[ $valinta =~ $re ]] ; then 		#Tarkastetaan syöte
	echo "ERROR: Wrong number" >&2;	

elif [[ $valinta == "1" ]] ; then 	#Valinta 1 Syöte, tulostetaan SSH Profiilit
	echo "Print SSH Profiles:"

	read -p "Filters: " filter


if [ -z "$filter" ]; then 
    cat ~/.ssh/config | grep host --color=always
else
    cat ~/.ssh/config | grep host | grep -A 1 $filter --color=always
fi


elif [[ $valinta == "2" ]] ; then	#Valinta 2 syöte, kirjaudutaan SSH profiiliin
        
read -p "Syöta SSH profiilin nimi: "  profiili
read -p "Käyttäjä jolla kirjaudutaan: " nimi


echo "Kirjaudutaan profiiliin $profiili käyttäjällä $nimi"

ssh $profiili -l $nimi

elif [[ $valinta == "3" ]] ; then	#Valinta 3 syöte, lisätään SSH profiili

read -p "Anna nimi hostille: " host
read -p "IP osoite palvelimelle: " ip
read -p "SSH yhteden portti: " port

echo "Host: $host & IP: $ip & Port: $port, onko OK?"

read -p "Type OK: " VAR1


if [ "$VAR1" = "OK" ]; then
    printf "host $host\n        hostname $ip\n  port $port\n\n" >> ~/.ssh/config
    printf "host: $host\n       hostname: $ip\n port: $port\nOn lisätty ~/.ssh/config\n"
else
    echo "Lisäystä ei tehty"
fi

elif [[ $valinta == "5" ]] ; then #Valinta 4, poistutaan ohjelmasta
        
exit;

elif [[ $valinta == "4" ]] ; then #Valinta 5, ssh-dss problem fix

echo -e "Host \n HostkeyAlgorithms +ssh-dss" >> ~/.ssh/config

fi


done



#@Artturi Kinnunen, 28.07.2020.


