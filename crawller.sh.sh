#!/bin/bash
#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
declare -a myarray
declare -a keywords_1
declare -a keywords_2
declare -a keywords_3
#keywords=('band teacher' 'orchestra teacher' 'private music teacher'
#'private lession' 'choir teacher' 'teacher Guitar' 'teacher Electric Guitar'
#'teacher Piano' 'teacher Violin' 'teacher Viola' 'teacher Cello'
#'teacher Bass' 'teacher Percussion' 'teacher Flute' 'teacher Open-Hole Flute'
#'teacher Clarinet' 'teacher Trumpet' 'teacher Trombone' 'teacher Marimba'
#'teacher Saxophone' 'teacher Clarinet' 'teacher Baritone' 'teacher Oboe'
#'teacher French Horn')
kewords_1=('Golf' 'Tennis' 'Racquet Ball', "Squash" 'Racquetball' 'badminton')
kewords_2=('Coach' 'Trainer' 'Instructor' 'Teacher' 'Manager')
kewords_3=('Pro' 'Professional' 'Junior' 'Assistant' 'Coordinator' 'Director' 'Private' 'Group' 'Local' 'Senior' 'masters' 'Youth')
# myarray
cd /mnt/Yellow-Page-Email-Scraper/
IFS=$'\n' a=($(cat statesname.txt))
for i in $(seq ${#a[*]}); do
    [[ ${a[$i-1]} = $name ]] && echo "${a[$i]}"

done
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
endKeyword="${#keywords_1[${#keywords_1[@]}-1]} ${#keywords_2[${#keywords_2[@]}-1]}  ${#keywords_3[${#keywords_3[@]}-1]} "

cp -rf ./scraper.js.bk ./scraper.js
if [ -d emails ]; then
	rm -rf emails/
fi 
if [ ! -d emails ]; then
	mkdir emails
fi
for (( c = 0; c < ${#a[@]}; c++ ))
do
	for keyword1 in $keywords_1
	do
	for keyword2 in $keywords_2
	do
	for keyword3 in $keywords_3
	do
		export lastKeyword="$keyword" #before keywrod runs
		export keyword="$keyword1 $keyword2 $keyword3"
		export putKeyword="$keyword1$keyword2$keyword3"
		echo "array total $purple${#a[@]}$nc"
		echo "on $green $c$nc"
		echo "on state $blue${a[$c]}$nc"
		echo "Replacing keyword $lastKeyword with $keyword"
		if [ ! -d ./emails/$putKeyword/ ]; then
			mkdir ./emails/$putKeyword/
		fi
		sudo casperjs scraper.js  >> ./emails/$putKeyword/${a[$c]}.txt
#		if (( $b > $(()) )); then
#			echo "$darkgray last keyword$nc"	
#			startKeyword="${keywords_1[0]} ${keywords_2[0]} ${keywords_3[0]}"
#			sudo sed -i.bak -e  "s/$keyword/$startKeyword/g" scraper.js #> scraper.js
#		else
			echo "not last keyword"
			sudo sed -i.bak -e  "s/$lastKeyword/$keyword/g" scraper.js #> scraper.js
#		fi
	done
	done
	done
	if (( $c > $((${#a[@]}-2)) )); then
		echo "$darkgray last state""
		echo "replacing ${a[$c]} with ${a[0]}"
		sudo sed -i.bak -e  "s/${a[$c]}/${a[0]}/g" scraper.js #> scraper.js
	else
		echo "not last state"
		echo "replacing ${a[$c]} with ${a[$c+1]}"
		sudo sed -i.bak -e  "s/${a[$c]}/${a[$c+1]}/g" scraper.js #> scraper.js
	fi
	echo "next " ${a[$c+1]}
done 
sudo zip -r9 emails.zip ./emails/
#gdrive upload emails.zip
sleep 20
sudo  poweroff -f
