#!/usr/bin/env bash

set -u
source ./config.sh
export CWD="$PWD"
export STEP_SIZE=200

PROG=$(basename $0 ".sh")
STDOUT_DIR="$CWD/out/$PROG"

init_dirs "$STDOUT_DIR"

if [[ ! -d $FASTQ_SPLIT ]]; then
  mkdir -p $FASTQ_SPLIT
fi

export FILES_LIST="$CWD/$0.in"

#
# find those fasta files!
#
find $FASTA_SPLIT -type f -iname \*.fa\* > $FILES_LIST

NUM_FILES=$(lc $FILES_LIST)

echo Found \"$NUM_FILES\" input files

#Check to make sure it's the proper amount of files (edit for your own case)
if [ $NUM_FILES -lt 5331 ]; then
  echo Nothing to do.
  exit 1
fi

JOB=$(qsub -W $GROUP -M $EMAIL -J 1-$NUM_FILES:$STEP_SIZE -v STEP_SIZE,SCRIPT_DIR,FILES_LIST,FASTA_SPLIT,FASTQ_SPLIT -N make_fastq -j oe -o "$STDOUT_DIR" $SCRIPT_DIR/makefastq.sh)

if [ $? -eq 0 ]; then
  echo Submitted job \"$JOB\" for you in steps of \"$STEP_SIZE.\" Sayonara.
else
  echo -e "\nError submitting job\n$JOB\n"
fi
