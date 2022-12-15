#! /usr/bin/perl -w
use strict;
my $in=shift;
open IN, "<$in" or die $!;
while(<IN>){
	chomp;
	if(/^#/){print "$_\n";next;}
	my @F=split/\t/;
	if(length($F[3]) <5 && length($F[4]) <5){
 		print "$_\n";
    }
}
close IN;
