#!/bin/sh
export LANG="pl_PL.UTF-8"
export LC_CTYPE="pl_PL.UTF-8"
export LC_NUMERIC="pl_PL.UTF-8"
export LC_TIME="pl_PL.UTF-8"
export LC_COLLATE="pl_PL.UTF-8"
export LC_MONETARY="pl_PL.UTF-8"
export LC_MESSAGES="pl_PL.UTF-8"
export LC_PAPER="pl_PL.UTF-8"
export LC_NAME="pl_PL.UTF-8"
export LC_ADDRESS="pl_PL.UTF-8"
export LC_TELEPHONE="pl_PL.UTF-8"
export LC_MEASUREMENT="pl_PL.UTF-8"
export LC_IDENTIFICATION="pl_PL.UTF-8"

# generate check files for each box file:
for boxfile in *.box; do
	checkfile="$(echo "$boxfile" | perl -pe 's/\.box$/.check/;')"
	tiffile="$(echo "$boxfile" | perl -pe 's/\.box$/.tif/;')"
	logfile="$(echo "$boxfile" | perl -pe 's/\.box$/.log/;')"
	# simple sanity check:
	if [ "$boxfile" = "$checkfile" ] || [ "$boxfile" = "$tiffile" ] || [ "$boxfile" = "$logfile" ]; then
		echo "ERROR!!! $boxfile shouldn't be the same as $checkfile or $tiffile or $logfile because it would be overwritten!"
		exit 1;
	else
		echo "checking $boxfile with output to $checkfile"
		./check_box.pl < "$boxfile" > "$checkfile"
		tesseract "$tiffile" junk nobatch box.train > $logfile 2>&1
	fi
	
done

mftraining *.tr
cntraining *.tr
unicharset_extractor *.box
mv inttemp pol.inttemp
mv normproto pol.normproto
mv pffmtable pol.pffmtable
mv unicharset pol.unicharset

echo
echo "Don't forget to correct pol.unicharset if your iswalpha/iswdigit functions malfunction (no pun intended)!"
