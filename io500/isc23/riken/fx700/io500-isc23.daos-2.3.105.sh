#!/bin/bash
#
#SBATCH        --job-name=d5_DFS
#SBATCH          --output=log.io500_dfs.daos_daos0.10-48.300sec.%J
#SBATCH           --error=log.io500_dfs.daos_daos0.10-48.300sec.%J
#SBATCH       --partition=fx700
#SBATCH       --exclusive
#SBATCH        --licenses=daos_daos0
#SBATCH        --nodelist="fx[00-09]"
#SBATCH           --nodes=10
#SBATCH --ntasks-per-node=48
#SBATCH --ntasks-per-core=1
#SBATCH            --time=4:00:00
#

export IO500_MODE="--mode=extended"
export IO500_MODE=""

export SLEEP_SEC=300

export DAOS_HOSTLIST="daos0"
export DAOS_POOL="u0001407"
export DAOS_CONT="cont0"
export DAOS_FUSE="/tmp/$USER/daos_${DAOS_POOL}_${DAOS_CONT}"

. $HOME/.bashrc

echo
echo `date`
echo
echo "Riken FX700 Slurm Job configuration:"
echo "* Jobid : $SLURM_JOB_ID"
echo "* Hosts : $SLURM_JOB_NODELIST"
echo "* Nodes : $SLURM_NNODES"
echo "* Ranks : $SLURM_NTASKS"
echo
echo "Riken FX700 DAOS configuration (daos_daos0):"
echo "* `daos version` (`rpm -qa daos`)"
echo "* DAOS_HOSTLIST=$DAOS_HOSTLIST"
echo "* DAOS_POOL=$DAOS_POOL"
echo "* DAOS_CONT=$DAOS_CONT"
echo "* DAOS_FUSE=$DAOS_FUSE"
echo


export FI_OFI_RXM_USE_SRX=1
export FI_VERBS_PREFER_XRC=1
#export FI_LOG_LEVEL="warn"
#export D_LOG_STDERR_IN_LOG=1


echo "------------------------------------------------------------"
echo
set | grep -E "^OFI|^FI_|^OMPI|^CRT|^LD_|^D_" | sort
echo
echo
echo "------------------------------------------------------------"


########################################################################

# INSTRUCTIONS:
#
# The only parts of the script that may need to be modified are:
#  - setup() to configure the binary locations and MPI parameters
# Please visit https://vi4io.org/io500-info-creator/ to help generate the
# "system-information.txt" file, by pasting the output of the info-creator.
# This file contains details of your system hardware for your submission.

# This script takes its parameters from the same .ini file as io500 binary.

MPI_BIND_TO="core"
MPI_BIND_TO="hwthread"
MPI_BIND_TO="none"
MPI_BIND_TO="ib0"
MPI_BIND_TO="socket"

mv "$1" "$1.$SLURM_JOB_ID"
io500_ini="$1.$SLURM_JOB_ID"          # You can set the ini file here
#io500_mpirun="mpiexec"
#io500_mpiargs="-np 2"

io500_mpirun="mpirun --bind-to $MPI_BIND_TO -genvall -genv DAOS_POOL $DAOS_POOL -genv DAOS_CONT $DAOS_CONT " # MPICH

io500_mpiargs=""

function setup(){
  local workdir="$DAOS_FUSE/$1"
  local resultdir="$2"
  echo "mkdir -p $workdir $resultdir"
  mkdir -p $workdir $resultdir
  echo "mkdir done (`date`)"
  echo -n "sleeping 30sec ... "
  sleep 30
  echo "finished sleeping"
  echo

  # Example commands to create output directories for Lustre.  Creating
  # top-level directories is allowed, but not the whole directory tree.
  #if (( $(lfs df $workdir | grep -c MDT) > 1 )); then
  #  lfs setdirstripe -D -c -1 $workdir
  #fi
  #lfs setstripe -c 1 $workdir
  #mkdir $workdir/ior-easy $workdir/ior-hard
  #mkdir $workdir/mdtest-easy $workdir/mdtest-hard
  #local osts=$(lfs df $workdir | grep -c OST)
  # Try overstriping for ior-hard to improve scaling, or use wide striping
  #lfs setstripe -C $((osts * 4)) $workdir/ior-hard ||
  #  lfs setstripe -c -1 $workdir/ior-hard
  # Try to use DoM if available, otherwise use default for small files
  #lfs setstripe -E 64k -L mdt $workdir/mdtest-easy || true #DoM?
  #lfs setstripe -E 64k -L mdt $workdir/mdtest-hard || true #DoM?
  #lfs setstripe -E 64k -L mdt $workdir/mdtest-rnd
}

# *****  YOU SHOULD NOT EDIT ANYTHING BELOW THIS LINE  *****
set -eo pipefail  # better error handling

if [[ -z "$io500_ini" ]]; then
  echo "error: ini file must be specified.  usage: $0 <config.ini>"
  exit 1
fi
if [[ ! -s "$io500_ini" ]]; then
  echo "error: ini file '$io500_ini' not found or empty"
  exit 2
fi


# MH::add DAOS container info (created in Slurm Prolog) to the ini template
mv ${io500_ini} ${io500_ini}.tmp
cat ${io500_ini}.tmp | sed "s/@STONEWALL/300/g; s/@NPROC/$SLURM_NTASKS/g; s/@DAOS_POOL/$DAOS_POOL/g; s/@DAOS_CONT/$DAOS_CONT/g; s#@DAOS_FUSE#$DAOS_FUSE#g" > ${io500_ini}
rm ${io500_ini}.tmp


function get_ini_section_param() {
  local section="$1"
  local param="$2"
  local inside=false

  while read LINE; do
    LINE=$(sed -e 's/ *#.*//' -e '1s/ *= */=/' <<<$LINE)
    $inside && [[ "$LINE" =~ "[.*]" ]] && inside=false && break
    [[ -n "$section" && "$LINE" =~ "[$section]" ]] && inside=true && continue
    ! $inside && continue
    #echo $LINE | awk -F = "/^$param/ { print \$2 }"
    if [[ $(echo $LINE | grep "^$param *=" ) != "" ]] ; then
      # echo "$section : $param : $inside : $LINE" >> parsed.txt # debugging
      echo $LINE | sed -e "s/[^=]*=[ \t]*\(.*\)/\1/"
      return
    fi
  done < $io500_ini
  echo ""
}

function get_ini_global_param() {
  local param="$1"
  local default="$2"
  local val

  val=$(get_ini_section_param global $param |
  	sed -e 's/[Ff][Aa][Ll][Ss][Ee]/False/' -e 's/[Tt][Rr][Uu][Ee]/True/')

  echo "${val:-$default}"
}

function run_benchmarks {
  $io500_mpirun $io500_mpiargs $PWD/io500-isc23 $io500_ini $IO500_MODE --timestamp $timestamp
}

create_tarball() {
  local sourcedir=$(dirname $io500_resultdir)
  local fname=$(basename ${io500_resultdir})
  local tarball=$sourcedir/io500-$HOSTNAME-$fname.tgz

  cp -v $0 $io500_ini $io500_resultdir
  tar czf $tarball -C $sourcedir $fname
  echo "Created result tarball $tarball"
}

function main {
  # These commands extract the 'datadir' and 'resultdir' from .ini file
  timestamp=$(date +%Y.%m.%d-%H.%M.%S)           # create a uniquifier
  [ $(get_ini_global_param timestamp-datadir True) != "False" ] &&
    ts="$timestamp" || ts="io500"
  # working directory where the test files will be created
  export io500_workdir=$(get_ini_global_param datadir $PWD/datafiles)/$ts

  [ $(get_ini_global_param timestamp-resultdir True) != "False" ] &&
    ts="$timestamp" || ts="io500"
  # the directory where the output results will be kept
  export io500_resultdir=$(get_ini_global_param resultdir $PWD/results)/$ts

  setup $io500_workdir $io500_resultdir
  run_benchmarks

  if [[ ! -s "system-information.txt" ]]; then
    echo "Warning: please create a 'system-information.txt' description by"
    echo "copying the information from https://vi4io.org/io500-info-creator/"
  else
    cp "system-information.txt" $io500_resultdir
  fi

  create_tarball
}

main

# MH::epilog - query pool, and allow time to quiece
echo
echo `date`
echo
echo "querying DAOS_POOL:"
echo
daos -j pool query $DAOS_POOL
echo
echo "sleeping $SLEEP_SEC seconds before returning ..."
sleep $SLEEP_SEC
echo
echo `date`
echo

