#!/bin/bash

module load snakemake trimmomatic bowtie2 samtools bedtools || exit 1

sbcmd="sbatch --cpus-per-task={cluster.ncpus} --mem={cluster.mem}"
sbcmd+=" --time={cluster.time} --partition={cluster.partition}"
sbcmd+=" {cluster.extra}"

#snakemake --unlock
snakemake -pr --keep-going --local-cores $SLURM_CPUS_PER_TASK --jobs 120 --cluster "$sbcmd" --cluster-config cluster.json --rerun-incomplete --max-jobs-per-second 1 --max-status-checks-per-second 0.01 --latency-wait 30 all

