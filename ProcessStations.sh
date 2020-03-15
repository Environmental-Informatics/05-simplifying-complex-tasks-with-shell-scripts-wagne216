#!/bin/bash
# created 2-26-20 by wagne216 (Danielle W.) for ABE 651 ass't 5

# Goal: Run this script to assess data from given stations in the StationData directory to (1) identify high elevation stations (2) Plot station locations and (3) convert the output figure into other formats.

# (PART 1) identify high elevation stations by searching through each file

# make higherElevation directory if does not exist
mdkir -p ./HigherElevation

# use a for loop to search through each file & identify which are higher than 200ft?
for file in StationData/*
do
# what is the file
	echo the file is $file
# identify altitudes > 200 m by searching through numbers next to known header text in each file
	LINE="$(grep Altitude $file)" # find line in the specific file
	echo the line is $LINE # test that the line is saved as a va
# 4th item in this line is the numeric altitude. save as var if >200
	above=`awk '{if($4>200) print$4}' <<<"$LINE"`
	echo altitude : $above 
# if the alt var saved is  not 0 then copy file to higher altitudes directory
	if [ ${#above} -ne 0 ]
	then
		cp "./$file" "./HigherElevation" 	
		echo $file copied
	else
		echo $file not copied
	fi

done	


# (PART 2): plot stations and save as img file

# extract  lat & long form each file in each folder

# long from stationdata:
awk '/Longitude/ {print -1* $NF}' StationData/Station_*.txt > Long.list
# lat from stationdata:
awk '/Latitude/ {print 1* $NF}' StationData/Station_*.txt > Lat.list
# compile long and lat into one file: 
paste Long.list Lat.list > AllStation.xy

# long from higherelevation:
awk '/Longitude/ {print -1 * $NF}' HigherElevation/Station_*.txt > HELong.list
# lat from higherelevation:
awk '/Latitude/ {print 1* $NF}' HigherElevation/Station_*.txt > HELat.list
# compile long and lat into one file: 
paste HELong.list HELat.list > HEStation.xy
echo station locations copied
cat HEStation.xy

# load Generic Mapping Tools (GMT)
module load gmt

# basic gmt fig (original plots)

# land, water, political bounds with higher res(-Dh) & specify filling in lakes (-Cl/) with blue 
gmt pscoast -Dh -JU16/4i -R-93/-86/36/43 -B2f0.5 -Ia/blue -Na/orange -P -K -V -Cl/blue > SoilMoistureStations.ps

# plot xy
# black, all stations
gmt psxy AllStation.xy -J -R -Sc0.25 -Gblack -K -O -V >> SoilMoistureStations.ps

# red, higher stations, smaller dots
gmt psxy HEStation.xy -J -R -Sc0.15 -Gred -O -V >> SoilMoistureStations.ps

# view figure
gv SoilMoistureStations.ps &

# convert to cropped box
ps2epsi SoilMoistureStations.ps SoilMoistureStations.epsi 

# open file:
gv SoilMoistureStations.epsi &

# image from  epsi to tiff file
convert -density 150 SoilMoistureStations.epsi SoilMoistureStations.tif

# view tif image
gv SoilMoistureStations.tif &
