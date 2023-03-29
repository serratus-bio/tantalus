#!/bin/bash
# getBAM.sh

SRA=$1

S3="s3://lovelywater2"

aws s3 cp $S3/bam/"$SRA".bam ./tmp.bam
aws s3 cp $S3/summary/"$SRA".summary ./summary/

samtools sort tmp.bam > bam/"$SRA".bam
samtools index bam/"$SRA".bam
