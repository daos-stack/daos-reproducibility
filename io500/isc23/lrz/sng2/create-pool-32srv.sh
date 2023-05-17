#!/bin/bash

D_USER="daosperf"
D_GROUP="users"
D_SIZE="800T"
D_RATIO="6,94"

D_POOL="lrz_32srv"
D_RANKS=`./rank2host |grep -v m02r01|cut -d' ' -f2|while read R ; do echo -n "$R," ; done|sed "s/,$//"`

echo "dmg pool create -u $D_USER -g $D_GROUP --size=$D_SIZE --tier-ratio=$D_RATIO --ranks=$D_RANKS $D_POOL"
      dmg pool create -u $D_USER -g $D_GROUP --size=$D_SIZE --tier-ratio=$D_RATIO --ranks=$D_RANKS $D_POOL

