package	Local::Row::JSON;
use JSON::XS;
use base qw(Local::Row);
use strict;
use warnings;
sub new{
	my $class = shift;
	my $source = JSON::XS->new->utf8->decode(@_);
	my $ref = $class->SUPER::new($source);	
	return $ref;
}

1;