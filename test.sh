keywords=('band teacher' 'orchestra teacher' 'private music teacher'
'private lession' 'choir teacher' 'teacher Guitar' 'teacher Electric Guitar'
'teacher Piano' 'teacher Violin' 'teacher Viola' 'teacher Cello'
'teacher Bass' 'teacher Percussion' 'teacher Flute' 'teacher Open-Hole Flute'
'teacher Clarinet' 'teacher Trumpet' 'teacher Trombone' 'teacher Marimba'
'teacher Saxophone' 'teacher Clarinet' 'teacher Baritone' 'teacher Oboe'
'teacher French Horn')

export num=21
 for (( b = 0; b < ${#keywords[@]}; b++ ))
do
echo $b
#echo "num " $((20 - 1))
if (( $b > $((${#keywords[@]}-2)) )); then
     echo "replacing ${keywords[$b]} with ${keywords[$b+1]}}"
	
	echo "fuck"
else 

fi
done
