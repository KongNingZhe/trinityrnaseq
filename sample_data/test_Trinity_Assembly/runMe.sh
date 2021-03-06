#!/bin/bash -ve


if [ -e reads.right.fq.gz ] && [ ! -e reads.right.fq ]; then
    gunzip -c reads.right.fq.gz > reads.right.fq
fi

if [ -e reads.left.fq.gz ] && [ ! -e reads.left.fq ]; then
    gunzip -c reads.left.fq.gz > reads.left.fq
fi



#######################################################
##  Run Trinity to Generate Transcriptome Assemblies ##
#######################################################

../../Trinity --seqType fq --max_memory 2G \
              --left reads.left.fq \
              --right reads.right.fq \
              --SS_lib_type RF \
              --CPU 4 

##### Done Running Trinity #####

if [ $* ]; then
    # check full-length reconstruction stats:
    ./test_FL.sh --query trinity_out_dir/Trinity.fasta --target __indiv_ex_sample_derived/refSeqs.fa --no_reuse
fi

