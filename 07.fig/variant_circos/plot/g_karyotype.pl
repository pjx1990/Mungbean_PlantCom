#!/usr/bin/perl
use strict;
use warnings;

open IN, "$ARGV[0]" or die $!;
my $i=1;
my $c1="green";
my $c2="dyellow";
while(<IN>){
	chomp;
	my @tmp=split /\s+/;
	#if($i>22){
	#	$i=$i-22;
	#}
	my $c=$tmp[0]%2;
	if($c==1){
		$i=$c1;
	}
	else{
		$i=$c2;
	}		
	print "chr\t-\t$tmp[0]\t$tmp[0]\t0\t$tmp[1]\t$i\n";
	$i++;
}
close IN;
