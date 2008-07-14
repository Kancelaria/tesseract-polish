#!/usr/bin/perl -w
# Copyright 2008 Aleksander Adamowski
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#		 http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Sat Jul 12 03:20:57 CEST 2008
# 
# Filters one wordlist (STDIN) based on other wordlist (a file given as command 
# line argument)  so that only words from the input (wordlist 1) which are not 
# present in the file (wordlist 2) are output.

my %filter_words;

open SUBTRACT, $ARGV[0];
my $word;
while ($word = <SUBTRACT>) {
	chomp($word);
	$filter_words{$word} = 1;
}
close SUBTRACT;

while ($word = <STDIN>) {
	chomp($word);
	if ($filter_words{$word}) {
		# Do nuffink...
	} else {
		print "$word\n";
	}
}
close SUBTRACT;

