#!/bin/sh
# by Aleksander Adamowski
# Sun Jul 13 21:18:07 CEST 2008
#
# Counts occurences of each character present in the given file

perl -pe 'use encoding utf8; s/(.)/$1\n/g;' < "$1"  | sort | uniq -c 

