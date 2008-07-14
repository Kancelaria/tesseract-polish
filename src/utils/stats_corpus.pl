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
# Fri Jul 11 17:52:23 CEST 2008
#
# Outputs contents of a BDB database that has the form key => occurence_count, 
# sorted in the order of increasing count.
# Output format has 2 columns: the key and its corresponding occurence count.
#
# Usually used on database files produced by parse_corpus.pl.
#
# Optionally can filter out a subset of keys based on a range of occurence 
# counts - this mode of operation is activated by supplying a 2nd and 3rd
# command line argument, which specify the lower and upper bound of desired 
# count range.
#
# In this mode, the output has a different format - one key per line, ready to
# be used as a simple wordlist. The occurence counts aren't output.
# Note that in this mode output is sorted by increasing count, not by the keys!
# If you need a wordlist sorted alphabetically, you have to do it by yourself.
#
# Example usage:
#
# To dump a database:
#
# ./stats_corpus.pl corpus_wordcount_2008-07-13_21h38m55s.db
#
# or to create a wordlist base on words that occur more frequent than 6 times 
# but less than 1000 times:
#
# ./stats_corpus.pl corpus_wordcount_2008-07-13_21h38m55s.db 7 999

use DB_File;
use Fcntl;

my $fname;
my $lower_bound;
my $upper_bound;

if ($#ARGV >= 0) {
	$fname = $ARGV[0];
	if (defined($ARGV[1]) && defined($ARGV[2])) {
		if ($ARGV[1] < $ARGV[2]) {
			$lower_bound = $ARGV[1];
			$upper_bound = $ARGV[2];
		} else {
			print STDERR "usage: $0 db_file [min_shown_count max_shown_count]\n".
					"min_shown_count has to be smaller than max_shown_count!\n";
		}
	}
} else {
	print STDERR "Podaj nazwe pliku do odczytania: \n";
	chomp($fname = <STDIN>);
}

tie (%database, 'DB_File', $fname, O_RDONLY, 0) || die ("Nie mozna otworzyc $fname!\n");

foreach $key (sort {$database{$a} <=> $database{$b} } keys %database) {
	if (defined($lower_bound) && defined($upper_bound)) {
		if ($database{$key} >= $lower_bound && $database{$key} <= $upper_bound) {
			print "$key\n";
		}
	} else {
		print "$key $database{$key}\n";
	}
}

untie(%database);

