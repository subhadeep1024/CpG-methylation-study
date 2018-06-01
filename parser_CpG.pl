@file=`cat $ARGV[0]`;
chomp(@file);

foreach $line(@file){
        chomp($line);
        @fields=split("\t",$line);
        @methylation=split(";",$fields[3]);
        @obsexp= split(",",$fields[4]);
        #print join("\t",@methylation)."\n";
        chomp(@methylation);
        $c1=$c2=$c3=$c4=$c5=$c6=$c7=$c8=$c9=$c10=0;
        foreach $per(@methylation){
                chomp $per;
                if($per<=10){
                        $c1++;
                }
                elsif($per>10 && $per<=20){
                        $c2++;
                }
                elsif($per>20 && $per<=30){
                        $c3++;
                }
                elsif($per>30 && $per<=40){
                        $c4++;
                }
                elsif($per>40 && $per<=50){
                        $c5++;
                }
                elsif($per>50 && $per<=60){
                        $c6++;
                }
                elsif($per>60 && $per<=70){
                        $c7++;
                }
                elsif($per>70 && $per<=80){
                        $c8++;
                }
                elsif($per>80 && $per<=90){
                        $c9++;
                }
                elsif($per>90){
                        $c10++;
                }
        }
        $cum_score=(($c1*0.1)+($c2*0.2)+($c3*0.3)+($c4*0.4))+($c5*0.5)+($c6*0.6)+($c7*0.7)+($c8*0.8)+($c9*0.9)+($c10*1);
        $normalized_score = $cum_score*$obsexp[0];
        print "$fields[0]\t$cum_score\t$obsexp[0]\t$normalized_score\n";
}
