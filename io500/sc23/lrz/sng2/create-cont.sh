#!/bin/bash

systemctl start daos_agent

D_USER="daosperf" ; D_POOL="lrz_42srv"

RF="--properties rd_fac:0"

echo "su - $D_USER -c \"daos cont create --type=POSIX $D_POOL $RF cont01_rf0\""
      su - $D_USER -c  "daos cont create --type=POSIX $D_POOL $RF cont01_rf0 "

