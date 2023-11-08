#!/bin/bash

D_USER="daosperf" ; D_GROUP="users" ; D_POOL="lrz_42srv" ; D_SIZE="1200T"

D_RATIO="6,94"

echo "dmg pool create -u $D_USER -g $D_GROUP --size=$D_SIZE --tier-ratio=$D_RATIO  $D_POOL"
      dmg pool create -u $D_USER -g $D_GROUP --size=$D_SIZE --tier-ratio=$D_RATIO  $D_POOL

