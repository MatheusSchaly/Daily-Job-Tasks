use strict;
use warnings;

package StringUtils;

sub zombify {
	my $word = shift @_;
	$word =~ s/[aeiou]/r/g;
	return $word;
}

return 1;
