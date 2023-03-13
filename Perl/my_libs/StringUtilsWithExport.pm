use strict;
use warnings;

package StringUtilsWithExport;
use Exporter ("import");
our @EXPORT_OK = ("zombify");

sub zombify {
	my $word = shift @_;
	$word =~ s/[aeiou]/r/g;
	return $word;
}

return 1;
