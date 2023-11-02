# DAOS Reproducibility - IO500-ISC23 - Riken - FX700

Reproducibility information for benchmarks submitted to the ISC23
[IO500](https://io500.org/list/isc23/io500) and
[10-Node](https://io500.org/list/isc23/ten) Lists.

General information on building and running the IO500 benchmarks with DAOS can be found in the
[DAOS Community Wiki](https://daosio.atlassian.net/wiki/spaces/DC/pages/11167301633/IO-500+SC22)
page on IO500.


## IO500.org Reproducibility Questionnaire

Answers to the _IO500.org Reproducibility Questionnaire_ are provided in the
[io500-reproducibility.riken-fx700.md](io500-reproducibility.riken-fx700.md) document.


## Institution

[Riken Center for Computational Science (R-CCS)](https://www.r-ccs.riken.jp/en/)

## Storage System

The DAOS storage cluster in Riken's FX700 cluster is a single Intel M50CYP
server, currently running DAOS Version 2.3.105-1 on Rocky Linux 8.7:

* 2x Intel Xeon Platinum 8360Y CPU @ 36 cores
* 16x 64GiB DDR4 Memory (3200MT)
* 16x [128GiB Intel Optane 200 Series Persistent Memory](https://ark.intel.com/content/www/us/en/ark/products/series/203877/intel-optane-persistent-memory-200-series.html)
* 8x [Solidigm/Intel D7-P5510 3.84TB U.2 NVMe SSD](https://www.solidigm.com/content/dam/solidigm/en/site/products/data-center/d7/p5510/documents/d7-p5510-series-product-brief.pdf)
* 2x Mellanox ConnectX-6 1-port InfiniBand EDR adapter

## Client Nodes

The FX700 cluster operated by RIKEN Center for Computational Science (R-CCS) is based on the same
Fujitsu A64FX CPUs as the [Supercomputer Fugaku](https://www.r-ccs.riken.jp/en/fugaku/about/).
Instead of the [Tofu-D](https://doi.org/10.1109/CLUSTER.2018.00090) torus interconnect of Fugaku,
it uses an InfiniBand EDR network as its HPC interconnect.

* [FUJITSU Supercomputer PRIMEHPC FX700](https://www.fujitsu.com/global/products/computing/servers/supercomputer/)
* [FUJITSU Processor A64FX](https://www.fujitsu.com/global/products/computing/servers/supercomputer/a64fx/)

## High-Performance Fabric

The HPC Fabric is an EDR InfiniBand network, using
[Mellanox SB7800](https://www.nvidia.com/en-us/networking/infiniband/sb7800/) switches.

Clients use single-port Mellanox ConnectX-5 EDR adapters.
The DAOS server uses two ConnectX-6 EDR adapters.
Each port is managed by a dedicated `daos_engine` running on that CPU socket.

## IO500 List Entries

* [Riken-FX700](https://io500.org/submissions/view/664)
  ranked [#44 on the ISC23 10-Node Research List #44](https://io500.org/list/isc23/ten)
* [Riken-FX700](https://io500.org/submissions/view/664)
 ranked [#57 on the ISC23 Research List #57](https://io500.org)

