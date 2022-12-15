($num,$den)=(0,0);
while ($cov=<STDIN>) {
    $num=$num+$cov;
    $den++;
}
$cov=$num/$den;
print "Mean Coverage = $cov\n";
