#######################################################################
# Copyright 2008 Aleksander Adamowski
#
# Licensed under the Apache License, Version 2.0 (the "License"); you
# may not use this file except in compliance with the License.  You
# may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.  See the License for the specific language governing
# permissions and limitations under the License.
#
#######################################################################
#
# Mental note to myself: in the future, make simpler makefiles for such
# simple projects
#
#######################################################################

GSOPTIONS = "-dTextAlphaBits=4"

.PHONY: allimages  allboxtxtfiles allboxfiles

nums := 0 1 2 3
fonts := courier helvetica times
boxfiles = $(foreach font, $(fonts), $(foreach num, $(nums), sample_pl-part$(num)-$(font).box))
boxtxtfiles = $(foreach font, $(fonts), $(foreach num, $(nums), sample_pl-part$(num)-$(font).box.txt))
tiffs = $(foreach font, $(fonts), $(foreach num, $(nums), sample_pl-part$(num)-$(font).tif))
postscripts = $(foreach font, $(fonts), $(foreach num, $(nums), sample_pl-part$(num)-$(font).ps))
foldeds = $(foreach num, $(nums), sample_pl-part$(num).folded)
parts =  $(foreach num, $(nums), sample_pl-part$(num).txt)

allboxfiles: $(boxfiles)
allboxtxtfiles: $(boxtxtfiles)
allimages: $(tiffs)

$(boxfiles): %.box: %.box.txt
	cp $< $@

$(boxtxtfiles): %.box.txt: %.tif
	tesseract $< $(subst .txt,,$@) batch.nochop makebox
	

# Requires gs from ghostscript package:
$(tiffs): %.tif: %.ps
	gs $(GSOPTIONS) -sDEVICE=tiffgray -sOutputFile=$@ -r300x300 - < $<

$(postscripts): $(foldeds)
	for part in $(foldeds); do \
		for font in $(fonts); do \
		 cedilla -fs $$font $$part `echo $$part | sed -e s/.folded//`-$$font.ps ;\
		done \
	done

$(foldeds): %.folded:  %.txt
	 cat $< | grep -v '^-$$' | fold -s > $@
	 

$(parts): sample_pl.txt
	csplit -f sample_pl-part -b '%d.txt' -n 1 sample_pl.txt '/^-$$/' '{*}'

# Requires a2ps from a2ps package:
#sample_pl-mono.ps sample_pl-sans.ps: sample_pl.latin2
#	fold -s sample_pl.latin2 | a2ps -1 -osample_pl-mono.ps -X ISO-8859-2 -Eplain --borders=no

#sample_pl.latin2: sample_pl.txt
#	recode UTF-8..ISO-8859-2 < sample_pl.txt  > sample_pl.latin2


clean:
	rm -f sample_pl.latin2 sample_pl-part*.txt *.folded *.ps *.png *.tif *.box

