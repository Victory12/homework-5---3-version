package Local::Reducer;
use strict;
use warnings;
our $VERSION = '1.00';

sub new {
		my ($class,%param) = @_;
		my $self = bless {source=>$param{"source"},row_class=>$param{"row_class"},initial_value=>$param{initial_value}},$class;
		return $self;
	}
sub reduced{
	my $self = shift;
	return $self->{initial_value};
}

sub reduce_n{
	my $self = shift;
	my $n = shift;
	my $max = undef;
	while ($self->{source}->{iterator} < $n){
		my $elem = $self->{source}->next;
		return $max unless defined $elem;
		$elem = $self->{row_class}->new($elem);
		$max = $self->reduce ($elem, $max);
		$self->{initial_value} = $max;

	}
	return $max;
}

sub reduce_all{
	my $self = shift;
	my $num = ($self->{source}->{data});
	my $n = $#$num + 1;
	my $max = $self->reduce_n($n);
	die "no data to reduce\n" unless defined $max;	
	return $max;
}
1;