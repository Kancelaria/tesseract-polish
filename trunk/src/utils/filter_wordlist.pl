#!/usr/bin/perl -w
# by Aleksander Adamowski
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

