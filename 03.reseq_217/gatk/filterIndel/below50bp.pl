#! /usr/bin/perl -w
use strict;
my $in=shift;
open IN, "<$in" or die $!;
while(<IN>){
	chomp;
	if(/^#/){print "$_\n";next;}
	my @F=split/\t/;
	#if(length($F[3]) <50 || length($F[4]) <50){
	#if(length($F[3]) <50 && length($F[4]) <50){
	if(length($F[3]) <15 && length($F[4]) <15){
 		print "$_\n";
    }
}
close IN;
