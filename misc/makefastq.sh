#!/usr/bin/env bash

#PBS -q standard
#PBS -l jobtype=cluster_only
#PBS -l select=1:ncpus=2:mem=4gb
#PBS -l walltime=24:00:00
#PBS -l cput=24:00:00
#PBS -m ea

#
# Gives 'fake' quality scores to fastas to turn them into fastq 
#

# expects:
# SCRIPT_DIR FILE_LIST FASTQ_SPLIT FASTA_SPLIT

set -u

COMMON="$SCRIPT_DIR/common.sh"

if [ -e $COMMON ]; then
  . "$COMMON"
else
  echo Missing common \"$COMMON\"
  exit 1
fi

echo Host \"$(hostname)\"

echo Started $(date)

TMP_FILES=$(mktemp)

get_lines $FILES_LIST $TMP_FILES $PBS_ARRAY_INDEX $STEP_SIZE

NUM_FILES=$(lc $TMP_FILES)

echo Found \"$NUM_FILES\" files to process

while read FILE; do

    echo "Processing $FILE"
    ./fasta_to_fastq.pl --file $FILE --outdir $FASTQ_SPLIT

done < $TMP_FILES

echo Finished $(date)
