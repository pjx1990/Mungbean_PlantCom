#! /usr/bin/perl -w
use strict;
my $in = shift;
open IN, "<$in" or die $!;
while(<IN>){
    chomp;
    my @F = split/\s+/;
    next if(/#/);
    print "1\t$F[2]\t$F[3]\t$F[4]\t$F[5]\t$F[6]\t$F[7]\t$F[8]\t$F[9]\t$F[10]\t$F[11]\n";
}
close IN;
