use strict;
use warnings;
use DDP;


use Local::Reducer::MaxDiff;
use Local::Source::Text;
use Local::Row::Simple;

my $diff_reducer = Local::Reducer::MaxDiff->new(
    top => 'received',
    bottom => 'sended',
    source => Local::Source::Text->new(text =>"sended:1024,received:2048\nsended:0,received:0\nsended:2048,received:10240"),
    row_class => 'Local::Row::Simple',
    initial_value => 0,
);


my $diff_result;
my $between;
$diff_result = $diff_reducer->reduce_n(1);

$between = $diff_reducer->reduced;
print "$diff_result and $between\n";

$diff_result = $diff_reducer->reduce_all();

print "$diff_result and $between\n";
$between = $diff_reducer->reduced;
print "$diff_result and $between\n";