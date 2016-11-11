package Local::Source;
use strict;
use warnings;


sub new{
  my $class = shift;
  my %data = @_;
  my @key = keys %data;
  my $self = bless {iterator => 0, source => $key[0], data => $data{$key[0]}}, $class;
  return $self;
}

sub next {
  my $self = shift;
  my $element = $self->{data}->[$self->{iterator}];
  if (defined $element){
     $self->{iterator}++; 
     return $element;
  }
  else{
    return undef;
  }  	 
}

1;

