datastorage=("Encode" "Blueprint" "NIH_Roadmap")

lenStorage=${#datastorage[@]}
 	
for ((j=0; j<$lenStorage; j++));
do

cd ${datastorage[$j]}

echo ${datastorage[$j]}
ls *txt > file

cat file | while read storage;
do
	
	#mkdir -p ${storage::-4}						#making the celltype folder						#entering the celltype folder
	cat $PWD"/"${datastorage[$j]}"/"${storage::-4}".txt" | while read line; 
	do 
		#echo $line
		#Selecting only Bed files
		if [[ ${line:(-3)} == "Bed" ]];then  
			echo $line;
			#wget $line;
			#echo *Bed $storage; 
		fi
	done
	cd ..
	
done
cd ..
done



