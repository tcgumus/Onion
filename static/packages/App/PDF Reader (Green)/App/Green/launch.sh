#!/bin/sh
sysdir=/mnt/SDCARD/.tmp_update
mediadir=/mnt/SDCARD/Media/PDF
appdir=$sysdir/bin/green

while :
do
	cd $sysdir
	./bin/st -q -e "$sysdir/script/file_selector.sh" $mediadir
	retVal=$?
	
	# if we catch that terminal app has been killed then we exit
	echo "=================" "$retVal"
	if [ $retVal -eq 137 ] || [ ! -f "$mediadir/.selected.pls" ]; then
		exit
	fi

	selected_file=$(cat "$mediadir/.selected.pls")

	if [ ! -f "$selected_file" ]; then
		continue
	fi

	echo "$selected_file"
	LD_LIBRARY_PATH="$sysdir/lib/parasyte:$LD_LIBRARY_PATH" $appdir/green "$selected_file"
done
