#!/bin/bash
##!/usr/bin/parallel --shebang-wrap --pipe /bin/bash --will-cite
cd `dirname $0`
#cd `pwd`
IFS=$'\n' a=($(cat statesname.txt))
for i in $(seq ${#a[*]}); do
    [[ ${a[$i-1]} = $name ]] && echo "${a[$i]}"

done
IFS=$'\n' keywords=($(cat keywords.csv))
for i in $(seq ${#keywords[@]}); do
    [[ ${keywords[$i-1]} = $name ]] && echo "${keywords[$i]}"

done
echo ${keywords[@]}
#echo myarray
black='\e[0;30m'
blue='\e[0;34m'
green='\e[0;32m'
cyan='\e[0;36m'
red='\e[0;31m'
nc='\e[0m'
purple='\e[0;35m'
brown='\e[0;33m'
lightgray='\e[0;37m'
darkgray='\e[1;30m'
lightblue='\e[1;34m'
lightgreen='\e[1;32m'
lightcyan='\e[1;36m'
lightred='\e[1;31m'
lightpurple='\e[1;35m'
inv="\x1B[8m"
#firstWord=`cat scraper.js.bk | grep "keyword:" | cut -d "'" -f 2-2 | cut -d "/" -f 1`
cp -rf ./scraper.js.bk ./scraper.js
sudo ssh away "bash /mnt/HDD/Programs//notifywithArgs.sh 'Your Craller is begining emails list' \"$(date)\""
if [ -d emails ]; then
	rm -rf emails/
fi
if [ ! -d emails ]; then
	mkdir emails
fi
rm -rf ./scraper_
#for (( c = 0; c < ${#a[@]}; c++ ))
#do
#        echo -e "not last state#"
#        echo -e "replacing ${a[$c]} with ${a[$c+1]}"
#        cp -rf ./scraper.js.bk $scraperFile
#        sudo sed -i.bak -e  "s|Arizona|${a[$c+1]}|g" $scraperFile #> scraper.js
#        echo "next  ${a[$c+1]}"
	for (( b = 0; b < ${#keywords[@]}; b++ ))
	do
		export keywordP1=`echo ${keywords[$b]} | cut -d ' ' -f 1`
		export keywordP2=`echo ${keywords[$b]} | cut -d ' ' -f 2`
		export keywordP3=`echo ${keywords[$b]} | cut -d ' ' -f 3`
		export keywordP4=`echo ${keywords[$b]} | cut -d ' ' -f 4`
		export putKeyword=$keywordP1+$keywordP2+$keywordP3+$keywordP4
		export scraperFile=./scraper_$putKeyword+${a[$c]}.js
		echo -e  "array total keywords  $purple${#keywords[@]}$nc"
		echo -e "on $green $b$nc"
		echo -e "on keyword $blue ${keywords[$b]}$nc"
		echo -e "$red*******************************$nc"
		echo -e "array total $purple${#a[@]}$nc"
		echo -e "on $green $c$nc"
		echo -e "on state $blue${a[$c]}$nc"
		if [ ! -d ./emails/$putKeyword/ ]; then
			mkdir ./emails/$putKeyword/
		fi
		sudo casperjs $scraperFile  >> ./emails/$putKeyword/${a[$c]}.txt &
		echo -e "replacing ${keywords[$b]} with ${keywords[$b+1]}"
		cp -rf ./scraper.js.bk $scraperFile
		export firstWord=`cat $scraperFile | grep "keyword:" | cut -d "'" -f 2-2 | cut -d "/" -f 2`
		echo "firstWord $firstWord"
		sudo sed -i.bak -e "s|${firstWord}|${keywords[$b+1]}|g" $scraperFile #> scraper.js
		echo "next " ${keywords[$b+1]}
	done
#done
#sudo zip -r9 emails.zip ./emails/
#gdrive upload emails.zip
sudo ssh away "bash /mnt/HDD/Programs//notifywithArgs.sh 'Your Craller is done emails list' \"$(date)\""
sleep 20
#sudo  poweroff -f
