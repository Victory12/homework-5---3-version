package Local::Reducer::MaxDiff;
use strict;
use warnings;
use base qw(Local::Reducer);
use Local::Row;
sub new {
	my ($class,%param) = @_;
	my $ref = $class->SUPER::new(%param);
	$ref->{top} = $param{"top"};
	$ref->{bottom} = $param{"bottom"};
	return $ref;
}

sub reduce{
	my $self = shift;
	my $elem = shift;
	my $max = shift;
	$max =  $self->{initial_value}; 
	my $top = $elem->get($self->{top},0);
	my $bottom = $elem->get($self->{bottom},0);
	my $source =  $top - $bottom; 
	$max = $source if $max < $source;
	return $max;
}

1;
