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
# Sun Jul 13 21:21:50 CEST 2008
# 
# This script reads a list of file pathnames on STDIN. The script then opens 
# each file and parses it assuming that it contains a XCES-coded text corpus.
# (I were using the corpus distributed in frek.xces.tar.bz2 from this page:
# http://korpus.pl/index.php?page=download)
#
# Ignoring all other data, it counts occurences of the base form of each word 
# (the <base> tag) in a hash (words are keys, values are the occurence counts).
#
# During processing, the hash is written out to a Berkeley DB database file 
# named "corpus_wordcount_CURRENT_TIMESTAMP.db". After processing it's also 
# dumped on STDOUT.
#
# Example usage:
# find XCES_corpus_dir/ -type f -name morph.xml | ./parse_corpus.pl

use Data::Dumper;
use XML::Parser::PerlSAX;
use CorpusHandler;
use encoding 'utf8';
use DB_File;
use DBM_Filter;

sub timestamp()
{
  (my $sec, my $min, my $hour, my $mday, my $mon, my $year, my $wday, my $yday, my $isdst) = localtime(time);
  $year += 1900;
  $mon++;
  my $timestamp = sprintf("%04d-%02d-%02d_%02dh%02dm%02ds", $year, $mon, $mday, $hour, $min, $sec);
  return $timestamp;
}


our %words_count = ( );
my $timestamp = timestamp();
my $db = tie %words_count, 'DB_File', "corpus_wordcount_$timestamp.db";
$db->Filter_Push('utf8');
#binmode($db->fd, ":utf8");
print Dumper(\%words_count);
my $my_handler = CorpusHandler->new(\%words_count);
my $parser = XML::Parser::PerlSAX->new( Handler => $my_handler );


while ($instance = <STDIN>) {
	chomp($instance);
	print "$instance\n";
	$parser->parse(Source => { SystemId => $instance });
}

print Dumper(\%words_count);
