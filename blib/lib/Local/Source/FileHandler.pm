package Local::Source::FileHandler;
use base qw(Local::Source);
use strict;
use warnings;
my $pos = 0;
my $fh = undef;
sub next{
	my $self = shift;
	my $sizef = -s($self->{data});
	open( $fh, "<", $self->{data}) unless defined $fh;
	$pos = tell ($fh);
	if ($pos >= $sizef-2){
		close $fh;
		return undef;
	}
	seek($fh, $pos, 0);
	my $element = <$fh>;
	chomp($element);
	$self->{iterator}++; 	
    return $element;	
}
1;


