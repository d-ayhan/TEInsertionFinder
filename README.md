# TEInsertionFinder

TEInsertionFinder is a pipeline designed to detect tranposon insertion sites which are not present in the reference.
It is a shell script which uses external software. Requirements:

picard (tested with 2.0.1)
bedtools (tested with 2.26.0)
samtools (tested with 1.3)

Inputs:
1. paired-end reads mapped to a reference, BAM
2. TE positions in reference, GFF

Outputs:
1. Alignments of the detected pairs in the insertion site, BAM
2. General  positions of the detected pairs, BED

The GFF file could be for single transposon, or multiple transposons. 
If it is the second case, current version cannot determine the type of the transposon of which the transposition detected.
It is a good practice to filterout suplementary and secondary mappings in the BAM file, since the pipeline considers them same as primary mapping.

USAGE:
TEInsertionFinder.sh INPUT.BAM TEs.GFF

