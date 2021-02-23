datastorage=("Encode" "Blueprint" "NIH_Roadmap")
				
lenStorage=${#datastorage[@]}
 	
for ((j=0; j<$lenStorage; j++));
do
	cd ${datastorage[$j]}
	echo ${datastorage[$j]}
	ls *txt > file 					#list of celltypes

	cat file | while read storage;
	do
		pwd=$PWD"/"
		mkdir -p ${storage::-4}			#making the celltypefolder	
		cd ${storage::-4}			#entering the celltype folder
		cat $pwd${storage::-4}".txt" | while read line;
		do 
			
			
			#Selecting only Bed files
			if [[ ${line:(-3)} == "Bed" ]];then 
				bbedfile=${line##*/}
				bb_file=${bbedfile::(-7)}.bed.gz
				if [[ -f $bb_file ]]
				then
					echo "$line exists on your filesystem."
					#transforming into bed
					if [[ ${bbedfile:(-3) == "Bed"} ]]
					then
						bigBedToBed $bbedfile stdout | gzip -c > ${bbedfile::(-7)}.bed.gz; 
						rm $bbedfile; 	#removing bigbed
					fi
				else
					echo "$line doesn't exist on your filesystem. NOW DOWNLOAD!!" 
					wget -nc $line; 			#Downloading
					#transforming into bed
					bigBedToBed $bbedfile stdout | gzip -c > ${bbedfile::(-7)}.bed.gz; 
					rm $bbedfile; 				#removing bigbed
				fi
			fi
		done
		cd ..
	
	done
	cd ..
done


