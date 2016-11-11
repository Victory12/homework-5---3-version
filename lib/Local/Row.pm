package Local::Row;
use strict;
use warnings;

sub get{
	my $self = shift;
	my($name, $default) = @_; 
  	return $self->{$name} if exists $self->{$name};
    return $default;
}
sub new{
	my ($class,$data) = @_;
	my $self = bless $data, $class;
	return $self;
}

1;