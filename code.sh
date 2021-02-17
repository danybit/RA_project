CellTypes=("BloodCellType" "GastrointestinalCellType" "LiverCellType" "PrimaryCellType" "ESCellType" "KidneyCellType" "LungCellType" "StromalCellType" "FatCelltype" "MuscleCellType" "CellLineCellType")

datastorage=("Encode" "Blueprint" "NIH_Roadmap")

lenCellTypes=${#CellTypes[@]}

lenStorage=${#datastorage[@]}
 	
echo $lenCellTypes 
	
message="This file is being downloaded "


for ((j=0; j<$lenStorage; j++));
do

database="/home/computer/ManchesterUniProject/"${datastorage[$j]}"/"	#for encode
mkdir ${datastorage[$j]}
cd ${datastorage[$j]}

for ((i=0; i<$lenCellTypes; i++));
do
	echo "$message${CellTypes[$i]}";

	mkdir ${CellTypes[$i]} 						#making the celltype folder
	cd ${CellTypes[$i]} 						#entering the celltype folder
	cat "$database${CellTypes[$i]}" | while read line; 
	do 
		#Selecting only Bed files
		if [[ ${line:(-3)} == "Bed" ]];then  
			echo $line;
			wget $line; 
		fi
	done
	cd ..
	
done
rm -d *
cd ..
done



