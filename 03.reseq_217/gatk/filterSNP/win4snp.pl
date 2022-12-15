#!/usr/bin/perl -w
use strict;

die  "Version 1.0\t2020-11-05;\nUsage: $0 <InPut><Out>\n" unless (@ARGV ==2);


open (IA,"$ARGV[0]") || die "input file can't open $!";
open (OA,">$ARGV[1]") || die "output file can't open $!" ;

my %hash=();
my $bin=5000; #5000        #choose one snp each 5bp
my $column=1; 
my  $Num=1;
while(<IA>) 
{ 
	chomp ;
	if  ($_=~s/#/#/) 
	{
		print OA  $_,"\n";
		next;
	}
	my @inf=split ;
	my $site=int($inf[$column]/$bin);
	my $key=$inf[0]."_".$site;
	if (!exists $hash{$key})
	{
		print OA $_,"\n";
		$hash{$key}=1;
	}
	else
	{
		$hash{$key}++;
		if ($hash{$key}<=$Num)
		{
			print OA $_,"\n";
		}
	}

}
close IA;
close OA ;

######################swimming in the sky and flying in the sea ##########################
