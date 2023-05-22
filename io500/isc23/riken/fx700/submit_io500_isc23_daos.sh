#!/bin/bash
#
# ISC23 IO500 build is in $HOME/io500-el8-isc23/
#

unset SLURM_MPI_TYPE

export LIC="daos_daos0" ; HW="fx700"

NICE="--nice=100"
NICE=""

HT=1 # hyperthreading off ( clients )

for WALL in 300 ; do

  for NODES in 10 ; do

    for TPN in 48 ; do

      for RF in 0 ; do

        cp -p io500-isc23.config-template.daos-rf${RF}.ini io500.config-full.${LIC}_rf${RF}.${NODES}-${TPN}.${WALL}sec.ini
        touch                                              io500.config-full.${LIC}_rf${RF}.${NODES}-${TPN}.${WALL}sec.ini

        cat io500-isc23.daos-2.3.105.sh | sed "s/@LIC/$LIC/g; s/@HW/$HW/g; s/@NODES/$NODES/g; s/@HT/$HT/g; s/@TPN/$TPN/g; s/@WALL/$WALL/g" \
                   > ./io500.${LIC}.${NODES}-${TPN}.${WALL}sec.sh

        sbatch $NICE ./io500.${LIC}.${NODES}-${TPN}.${WALL}sec.sh io500.config-full.${LIC}_rf${RF}.${NODES}-${TPN}.${WALL}sec.ini

      done
    done
  done
done


