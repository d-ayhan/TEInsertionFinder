#!/bin/bash
# DEFINITION: Maps and counts fastq reads to given reference sequences. Requires: picard, bedtools, samtools
# USAGE:
# TEInsertionFinder INPUT.BAM TEs.GFF
# Authors: Ayhan, DH; Sohrab, V

BAM_input=$1
gff_input=$2
tmpdir="TMP_"$BAM_input"_"$(date +"%Y%m%d%H%M")

bedtools intersect -abam $BAM_input -b $gff_input -wa > $tmpdir"/1.bam"
samtools view -o $tmpdir"/2.sam" $tmpdir"/1.bam"
awk '{if ($7 != "=") print $1}' $tmpdir"/2.sam" > $tmpdir"/3.txt"
java -jar picard.jar FilterSamReads I=$BAM_input O=$BAM_input"_alignments.bam" READ_LIST_FILE=$tmpdir"/3.txt" FILTER=includeReadList
bedtools merge -d 100 -i $BAM_input"_alignments.bam" > $tmpdir"/4.bed"
awk '{if ($3 - $2 > 500) print $0}' $tmpdir"/4.bed" > $BAM_input"_ins.bed"
rm -r $tmpdir
