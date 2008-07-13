#!/usr/bin/perl -w
# by Aleksander Adamowski
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
