package Local::Source::Text;
use base qw(Local::Source);
use strict;
use warnings;

sub new{
	my $class = shift;
	my %data = @_;
	$data{text} = [ split ("\n", $data{text}) ];
	my $ref = $class->SUPER::new( "text", $data{text} );
  	return $ref;	
}

1;


