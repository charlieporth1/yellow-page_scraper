#!/bin/bash
declare -a keywords_3=("teacher" "instructor" "lessons" "lesson" "tutor" "coach" "trainer")
declare -a keywords_2=("private" "public" "pro" "group")
declare -a keywords_1
IFS=$',' keywords_1=($(cat insturments.csv))
for i in $(seq ${#keywords_1[*]}); do
    [[ ${keywords_1[$i-1]} = $name ]] && echo "${keywords_1[$i]}"

done
for keyword1 in ${keywords_1[@]}
do
for keyword2 in ${keywords_2[@]}
do
for keyword3 in ${keywords_3[@]}
do
keyword="$keyword2 $keyword3 $keyword1"
echo $keyword
echo "$keyword" >> keywords.csv
done

done

done
