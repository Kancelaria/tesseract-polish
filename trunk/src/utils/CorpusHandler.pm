
package CorpusHandler;

=head1 NAME

CorpusHandler - SAX parser handler for counting occurences of words in a XCES 
text corpus

=head1 DESCRIPTION

 This module handles parsing of XCES-coded text corpus
 and updating of word occurence count in a hash.

=cut

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

=head1 COPYRIGHT

 Copyright 2009 Aleksander Adamowski

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

		 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.

=cut


1;
