#!/usr/bin/perl
use strict;
use warnings;

open IN1, "$ARGV[0]" or die $!;
open IN2, "$ARGV[1]" or die $!;

my $w=1000000;
my %hash;
my %plus;
my %minus;
while(<IN1>){
	chomp;
	my @tmp=split /\s+/;
	$hash{$tmp[3]}=$tmp[5];
	my $windows=int($tmp[5]/$w);
	for(my $i=0; $i<=$windows; $i++){
		$plus{$tmp[3]}{$i}=0;
		$minus{$tmp[3]}{$i}=0;
	}
}
close IN1;

while(<IN2>){
	chomp;
	next if(/^$/);
	my @tmp=split /\s+/;
	my $key1=int($tmp[3]/$w);
	my $key2=int($tmp[4]/$w);
	if($key1 ne $key2){
		if($tmp[2] eq '+'){
			$plus{$tmp[1]}{$key1} += 1;
			$plus{$tmp[1]}{$key2} += 1;
		}
		if($tmp[2] eq '-'){
                        $minus{$tmp[1]}{$key1} += 1;
                        $minus{$tmp[1]}{$key2} += 1;
                }
	}
	if($key1 eq $key2){
		if($tmp[2] eq '+'){
                        $plus{$tmp[1]}{$key1} += 1;
                }
                if($tmp[2] eq '-'){
                        $minus{$tmp[1]}{$key1} += 1;
                }
        }
}

#open OUT1, ">gene_plus.txt" or die $!;
#open OUT2, ">gene_minus.txt" or die $!;
foreach my $key(sort keys %plus){
	foreach my $key2(sort {$a<=>$b} keys %{$plus{$key}}){
		my $sta=$key2*$w;
		my $end=$sta+$w;
		if($end>$hash{$key}){
			$end=$hash{$key};
		}
		my $num = $plus{$key}{$key2}+$minus{$key}{$key2};
		print  "$key\t$sta\t$end\t$num\n";

		#print OUT1 "$key\t$sta\t$end\t$plus{$key}{$key2}\n";
		#print OUT2 "$key\t$sta\t$end\t$minus{$key}{$key2}\n";
	}
}

#close OUT1;
#close OUT2;
