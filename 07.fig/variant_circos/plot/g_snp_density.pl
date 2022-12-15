#!/usr/bin/perl
use strict;
use warnings;

open IN1, "$ARGV[0]" or die $!;
open IN2, "$ARGV[1]" or die $!;

my $w=1000000;
my %num;
my %hash;
my %plus;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/;
	$hash{$tmp[3]}=$tmp[5];
	my $windows=int($tmp[5]/$w);
	for(my $i=0; $i<=$windows; $i++){
		$plus{$tmp[3]}{$i}=0;
	}
}
close IN1;

while(<IN2>){
	chomp;
	next if(/^$/);
	my @tmp=split /\s+/;
	my $key1=int($tmp[1]/$w);
	my $key2=int($tmp[2]/$w);
	unless(exists $num{$tmp[0]}{$key1}){
		$num{$tmp[0]}{$key1}=0;
	}
	unless(exists $num{$tmp[0]}{$key2}){
		$num{$tmp[0]}{$key2}=0;
	}
	if($key1 ne $key2){
		$plus{$tmp[0]}{$key1} += $tmp[3];
		$plus{$tmp[0]}{$key2} += $tmp[3];
		$num{$tmp[0]}{$key1}++;
		$num{$tmp[0]}{$key2}++;
	}
	if($key1 eq $key2){
                $plus{$tmp[0]}{$key1} += $tmp[3];
		$num{$tmp[0]}{$key1}++;
        }
}


foreach my $key(sort keys %plus){
	foreach my $key2(sort {$a<=>$b} keys %{$plus{$key}}){
		my $sta=$key2*$w;
		my $end=$sta+$w;
		if($end>$hash{$key}){
			$end=$hash{$key};
		}
		if(exists $num{$key}{$key2} && $num{$key}{$key2} > 0){
			my $gc = $plus{$key}{$key2};
			print  "$key\t$sta\t$end\t$gc\n";
		}
	}
}
