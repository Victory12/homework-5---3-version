package	Local::Row::Simple;
use base qw(Local::Row);
use strict;
use warnings;
sub new{
	my $class = shift;
	my $str = shift;
	my $hash;
	while ($str =~/([^,:]*):([^,:]*)/g)
	{
		$hash->{$1} = $2;
	}
	my $ref = $class->SUPER::new($hash);	
	return $ref;
}

1;