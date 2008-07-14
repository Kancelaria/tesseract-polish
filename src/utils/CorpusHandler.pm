# This module handles parsing of XCES-coded text corpus
# and updating of word occurence count in a hash.

package CorpusHandler;

use Data::Dumper;
use encoding 'utf8';

our $ref_words_count;
our $in_base = 0;

sub new {
    my $type = shift;
		$ref_words_count = shift;
		#%words_count = %{$ref_words_count};
		#print "in new()\n";
		#print Dumper(\%words_count);
		#print Dumper($ref_words_count);
    return bless {}, $type;
}


sub start_element {
    my ($self, $element) = @_;

		if (lc($element->{Name}) eq 'base') {
			#print "Start element: $element->{Name}\n";
			$in_base = 1;
		}
}

sub end_element {
    my ($self, $element) = @_;
		if (lc($element->{Name}) eq 'base') {
			#print "End element: $element->{Name}\n";
			$in_base = 0;
		}
}

sub characters {
	my ($self, $data) = @_;
	if ($in_base) {
			my $word = $data->{Data};
			#print "Got characters: $word\n";
			${$ref_words_count}{$word}++;
	}
}

sub end_document {
	print "End document\n";
}

1;
