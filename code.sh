CellTypes=("BloodCellType" "GastrointestinalCellType" "LiverCellType" "PrimaryCellType" "ESCellType" "KidneyCellType" "LungCellType" "StromalCellType")


len=${#CellTypes[@]}
 	
echo $len 
database="/home/computer/ManchesterUniProject/Encode/"  #for encode	
message="This file is being downloaded "
for ((i=0; i<$len; i++));
do
	echo "$message${CellTypes[$i]}";
	folder="_f"
	celltype="$database${CellTypes[$i]}$folder"
	mkdir "$celltype" #making the celltype folder
	cd "$celltype" #entering the celltype folder
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



