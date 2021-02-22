datastorage=("Encode" "Blueprint" "NIH_Roadmap")
				
lenStorage=${#datastorage[@]}
 	
for ((j=0; j<$lenStorage; j++));
do
	cd ${datastorage[$j]}
	echo ${datastorage[$j]}
	ls *txt > file

	cat file | while read storage;
	do
		pwd=$PWD"/"
		mkdir -p ${storage::-4}			#making the celltypefolder
		cd ${storage::-4}			#entering the celltype folder
		cat $pwd${storage::-4}".txt" | while read line;
		do 
			#Selecting only Bed files
			if [[ ${line:(-3)} == "Bed" ]];then  
				wget -nc $line; 			#Downloading
				./bigBedToBed $line ${line::(-6)}.bed;  #transforming into bed
				rm $line; 				#removing bigbed
			fi
		done
		cd ..
	
	done
	cd ..
done


