#/data/software/soft/3d-dna/run-asm-pipeline-post-review.sh -r genome.rawchrom.review.assembly ../reference/genome.fa ../aligned/merged_nodups.txt 
sshpass -p $(cat temp) rsync -aPv -e 'ssh -p 9022' genome.FINAL.fasta.gz fujun@222.240.236.178:/results/fujun/
