use strict;
use warnings;


use DDP;
use Local::Reducer::MinMaxAvg;
use Local::Source::FileHandler;
use Local::Row::JSON;

my $reducer = Local::Reducer::MinMaxAvg->new(
    field => 'price',
    source => Local::Source::FileHandler->new(FileHandler => "data.txt"),
    row_class => 'Local::Row::JSON',
    initial_value => 0,
);



my $result = $reducer->reduce_n(2);
p $result;
my $min = $result->get_min;
p $min;
my $max = $result->get_max;
p $max;
my $agv = $result->get_avg;
p $agv;
print "all\n";
$result = $reducer->reduce_all;
p $result;
$min = $result->get_min;
p $min;
$max = $result->get_max;
p $max;
$agv = $result->get_avg;
p $agv;