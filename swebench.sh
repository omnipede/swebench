#!/bin/bash
#SBATCH --job-name=swebench
#SBATCH --comment="SWE-Bench-Verified evaluation"
#SBATCH --nodelist=nv172
#SBATCH --cpus-per-task=32
#SBATCH --mem-per-cpu=4G

##### Number of total processes
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "
echo "Job name:= " "$SLURM_JOB_NAME"
echo "Nodelist:= " "$SLURM_JOB_NODELIST"
echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX "

echo "Run started at:- "
date

mkdir -p singularity/tmp
mkdir -p singularity/cache

# 이 설정 없으면, 실행 중 "no space left on device" 에러 발생함
export SINGULARITY_BIND="$PWD/singularity/tmp:/tmp,$PWD/singularity/cache:/root/.cache"

srun mini-extra swebench \
    --subset verified \
    --split test \
    -c swebench.yaml \
    --slice 0:4 \
    -o ./output_$SLURM_JOB_ID \
    --workers 4