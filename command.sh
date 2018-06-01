

echo "recompressing .gz files"
zcat ENCFF001TLC.bed.gz | grep -v "^track" | sort -nk2 | gzip > BE2C_rep1.bed.gz
zcat ENCFF001TLD.bed.gz | grep -v "^track" | sort -nk2 | gzip > BE2C_rep2.bed.gz

echo "unifying replicates"
### if difference between replicates is less than 20, the site is accepted for further analysis
intersectBed -a BE2C_rep1.bed.gz -b BE2C_rep2.bed.gz -wa -wb -s | cut -f1,2,3,6,11,22 | perl -ne '@a=split("\t",$_); $avg_perc_meth = ($a[4]+$a[5])/2; if(abs($a[4]-$a[5])<=20){print "$a[0]\t$a[1]\t$a[2]\t$avg_perc_meth\t.\t$a[3]\n"}'> BE2C_RRBS_MsP1.bed


echo "Running intersectBed"
intersectBed -a /home/sutripa/subhadeep/GENCODE_annotations/final/TSS_CpG.bed -b BE2C_RRBS_MsP1.bed -wa -wb -s | awk '{print $4"\t"$2"\t"$3"\t"$12"\t"$7"\t"$6}'| sort -nk2 > tmp1

echo "Running mergeBed"
mergeBed -i tmp1 -s -nms -scores collapse > BE2C_clustered_d10_TSS_up1000_down500_RRBS_overlap

echo "calculating promoter methylation"
perl parser_CpG.pl BE2C_clustered_d10_TSS_up1000_down500_RRBS_overlap > BE2C_TSS_methylation
