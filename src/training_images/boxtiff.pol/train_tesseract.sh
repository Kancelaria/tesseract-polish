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

tesseract sample_pl-part0-courier.tif junk nobatch box.train > sample_pl-part0-courier.log 2>&1
tesseract sample_pl-part0-helvetica.tif junk nobatch box.train > sample_pl-part0-helvetica.log 2>&1
tesseract sample_pl-part0-times.tif junk nobatch box.train > sample_pl-part0-times.log 2>&1
tesseract sample_pl-part1-courier-digital_cam.tif junk nobatch box.train > sample_pl-part1-courier-digital_cam.log 2>&1
tesseract sample_pl-part1-helvetica-digital_cam.tif junk nobatch box.train > sample_pl-part1-helvetica-digital_cam.log 2>&1
mftraining *.tr
cntraining *.tr
unicharset_extractor sample_pl-part0-courier.box \
	sample_pl-part0-helvetica.box \
	sample_pl-part0-times.box \
	sample_pl-part1-courier-digital_cam.box \
	sample_pl-part1-helvetica-digital_cam.box
mv inttemp pol.inttemp
mv normproto pol.normproto
mv pffmtable pol.pffmtable
mv unicharset pol.unicharset
echo
echo "Don't forget to correct pol.unicharset if your iswalpha/iswdigit functions malfunction (no pun intended)!"
