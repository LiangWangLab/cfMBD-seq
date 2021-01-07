for i in $(ls -R | grep '.*[.]fastq.gz' | cut -c 1-2 | uniq)
do   
       echo Merging $i into one fastq
       cat ./*/${i}_*.fastq.gz > $i.fastq.gz
       echo fastp QC of $i
       fastp -i $i.fastq.gz -o $i.fastp.fastq.gz -j $i.fastp.json -h $i.fastp.html -R $i
       rm $i.fastq.gz
       mv "$i.fastp.fastq.gz" "$i.fastq.gz"
       echo Bowtie2 single-end alignment of $i
       bowtie2 -x hg19 -U $i.fastq.gz -S $i.sam -D 15 -R 2 -N 0 -L 20 -i S,1,0.75 -p 6
       rm $i.fastq.gz
       echo Convert $i sam to bam
       samtools view -S -b $i.sam > $i.bam -@ 6
       rm $i.sam
       echo Sort $i
       samtools sort -@ 6 -m 2g $i.bam -o $i.sorted.bam 
       rm $i.bam 
       mv "$i.sorted.bam" "$i.bam"     
       echo Optional-$i Extract chr1-chr22
       samtools index $i.bam
       samtools view -b $i.bam chr{1..22} >$i.chr.bam -@ 6
       rm $i.bam
       mv "$i.chr.bam" "$i.bam"
       rm $i.bam.bai      
       echo Index $i        
       samtools index $i.bam
       echo $i is completed
done

