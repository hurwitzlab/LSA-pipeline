#!/usr/bin/env python

import sys,getopt,os

SplitInput_string = """#!/bin/bash
#PBS -N SplitInput[1-%numSamples%]
#PBS -o Logs/SplitInput-Out-%I.out
#PBS -e Logs/SplitInput-Err-%I.err
#PBS -W group_list=bhurwitz
#PBS -q standard
#PBS -l jobtype=cluster_only
#PBS -l select=1:ncpus=6:mem=11gb
#PBS -l pvmem=22gb
#PBS -l place=pack:shared
#PBS -l walltime=48:00:00
#PBS -l cput=48:00:00
#PBS -M scottdaniel@email.arizona.edu
#PBS -m bea
echo Date: `date`
t1=`date +%s`
sleep ${PBS_ARRAY_INDEX}
python PBS_Scripts/array_merge.py -r ${PBS_ARRAY_INDEX} -i %input% -o original_reads/
[ $? -eq 0 ] || echo 'JOB FAILURE: $?'
echo Date: `date`
t2=`date +%s`
tdiff=`echo 'scale=3;('$t2'-'$t1')/3600' | bc`
echo 'Total time:  '$tdiff' hours'
"""

help_message = "usage example: python setupDirs.py -i /path/to/reads/ -n numberOfSamples"
if __name__ == "__main__":
	try:
		opts, args = getopt.getopt(sys.argv[1:],'hi:n:',["inputdir="])
	except:
		print help_message
		sys.exit(2)
	for opt, arg in opts:
		if opt in ('-h','--help'):
			print help_message
			sys.exit()
		elif opt in ('-i','--inputdir'):
			inputdir = arg
			if inputdir[-1] != '/':
				inputdir += '/'
		elif opt in ('-n'):
			n = arg
	for dir in ['Logs','original_reads','hashed_reads','cluster_vectors','read_partitions']:
		os.system('mkdir %s' % (dir))
	f = open('PBS_Scripts/SplitInput_ArrayJob.q','w')
	f.write(SplitInput_string.replace('%numSamples%',n).replace('%input%',inputdir))
	f.close()
