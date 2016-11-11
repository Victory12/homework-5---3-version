use strict;
use warnings;

use DDP;
use Local::Reducer::Sum;
use Local::Source::Array;
use Local::Row::JSON;

my $sum_reducer = Local::Reducer::Sum->new(
    field => 'price',
    source => Local::Source::Array->new(array => [
        '{"price": 0}',
        '{"price": 1}',
        '{"price": 2}',
        '{"price": 3}',
    ]),
    row_class => 'Local::Row::JSON',
    initial_value => 0,
);



my $sum_result;
my $between;
$sum_result = $sum_reducer->reduce_n(3);

$between = $sum_reducer->reduced;
print "$sum_result and $between\n";

$sum_result = $sum_reducer->reduce_all;
print "$sum_result and $between\n";
$between = $sum_reducer->reduced;
print "$sum_result and $between\n";