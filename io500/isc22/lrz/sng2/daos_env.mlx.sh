# DAOS 2.0 client-side settings for Mellanox InfiniBand:

THISUSER=$(whoami)

export D_LOG_MASK="WARN"
export D_LOG_STDERR_IN_LOG=0 # stderr in application output
export D_LOG_FILE="/tmp/daos.$THISUSER.log"

export FI_UNIVERSE_SIZE=16383
export FI_OFI_RXM_USE_SRX=1
export FI_VERBS_PREFER_XRC=1

