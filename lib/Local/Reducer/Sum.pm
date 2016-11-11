package Local::Reducer::Sum;
use strict;
use warnings;
use base qw(Local::Reducer);
use Local::Row;
sub new {
	my ($class,%param) = @_;
	my $ref = $class->SUPER::new(%param);
	$ref->{field} = $param{"field"};
	return $ref;
}

sub reduce{
	my $self = shift;
	my $elem = shift;
	my $max = shift;
	$max = $self->{initial_value} unless defined $max;
	my $source = $elem->get($self->{field},0);
	$max += $source;
	return $max;
}

1;
 