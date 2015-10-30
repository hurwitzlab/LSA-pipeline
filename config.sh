#!/usr/bin/env bash
#
# File to hold all your directory settings
#

#
# Some constants
#
export QSTAT="/usr/local/bin/qstat_local"
export GUNZIP="/bin/gunzip"
export EMAIL="scottdaniel@email.arizona.edu"
export GROUP="bhurwitz"

#
# Directories
#
export PROJECT_DIR="/rsgrps/bhurwitz/scottdaniel/LSA-pipeline"
export FASTA_SPLIT="/gsfs1/rsgrps/bhurwitz/scottdaniel/uproc_shortread_to_pfam/data/split"
export FASTQ_SPLIT="$PROJECT_DIR/fastq_split"
export SCRIPT_DIR="$PROJECT_DIR/misc"
#
# Just for fun, directory to raw fastq reads, both DNA and RNA
export RAW_DIR="/rsgrps/bhurwitz/hurwitzlab/data/raw/Doetschman_20111007/all"
# Some custom functions for our scripts
#
# --------------------------------------------------
function init_dirs {
    for dir in $*; do
        if [ -d "$dir" ]; then
            rm -rf $dir/*
        else
            mkdir -p "$dir"
        fi
    done
}

# --------------------------------------------------
function lc() {
  FILE=${1:-''}
  if [ -e $FILE ]; then
    wc -l $FILE | cut -d ' ' -f 1
  else 
    echo 0
  fi
}
