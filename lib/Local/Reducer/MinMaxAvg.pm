package Local::Reducer::MinMaxAvg;
use strict;
use warnings;
use base qw(Local::Reducer);
use Local::Row;
use List::Util;
sub new {
	my ($class,%param) = @_;
	my $ref = $class->SUPER::new(%param);
	$ref->{field} = $param{"field"};
	return $ref;
}
sub reduce_new{
	my $self = shift;
	my $ref = bless [], $self;
	return $ref;
}

sub reduce{
	my $self = shift;
	my $elem = shift;
	my $array = shift;
	unless (defined $array){
	 	if ( ref $self->{initial_value} eq ""){ 		
	 		$array = Local::Reducer::MinMaxAvg->reduce_new;
	 	}
	 	else{
	 		$array = $self->{initial_value};
	 	}
	 }
	my $source = $elem->get($self->{field},0);
	push @$array, $source;
	return $array;

}
sub reduce_all{
	my $self = shift;
	my $n = `wc -l $self->{source}->{data}`;
	$n =~ s/[^0-9]//g;
	my $max = $self->reduce_n($n-1);
	die "no data to \n" unless defined $max;
	return $max;
}	

sub get_min{
	my $self = shift;
	my $foo = List::Util::reduce { $a < $b ? $a : $b } @$self;	
	return $foo;
}
sub get_max{
	my $self = shift;
	my $foo = List::Util::reduce { $a > $b ? $a : $b } @$self;
	return $foo;
}
sub get_avg{
	my $self = shift;
	my $foo = (List::Util::reduce { $a + $b } @$self ) /($#$self+1);	
	return $foo;
}
1;
