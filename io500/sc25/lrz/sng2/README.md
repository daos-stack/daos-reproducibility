# IO500-SC25 - LRZ - SuperMUC-NG Phase2

Reproducibility information for benchmarks submitted to the IO500-SC25
[Production](https://io500.org/list/sc25/production) list,
[10-Node Production](https://io500.org/list/sc25/ten-production) list,
[Research](https://io500.org/list/sc25/io500) list, and
[10-Node Research](https://io500.org/list/sc25/ten) list.

General information on building and running the IO500 benchmarks with DAOS can be found in the
[DAOS Community Wiki](https://daosio.atlassian.net/wiki/spaces/DC/pages/11167301633/IO-500+SC22)
page on IO500.


## IO500.org Reproducibility Questionnaire

Answers to the _IO500.org Reproducibility Questionnaire_ are provided in the
[io500-reproducibility.lrz-sng2.md](io500-reproducibility.lrz-sng2.md) document.
Note that this document covers two different _user-selectable_ data protection schemes
to address the different requirements of the _Production_ list and _Research_ list.


## Institution

[LRZ](https://www.lrz.de/)

This supercomputer is Phase Two of LRZ's
[SuperMUC-NG](https://doku.lrz.de/pages/viewpage.action?pageId=64815239).


## Storage System

The DAOS storage cluster in LRZ's SuperMUC-NG Phase2 system consists of
42x Lenovo SR630v2 servers, currently running DAOS Version 2.6.4-2 on SLES 15.5:

* 2x Intel Xeon Platinum 8352Y CPU @ 2.20GHz
* 16x 32GiB TruDDR4 Memory (3200MT)
* 16x [128GiB Intel Optane 200 Series Persistent Memory](https://ark.intel.com/content/www/us/en/ark/products/series/203877/intel-optane-persistent-memory-200-series.html)
* 8x [Solidigm/Intel D7-P5500 3.84TB U.2 NVMe SSD](https://www.solidigm.com/content/dam/solidigm/en/site/products/data-center/d7/p5510/documents/d7-p5510-series-product-brief.pdf)
* 2x Mellanox ConnectX-6 1-port InfiniBand HDR adapter

Reference information for the storage solution:

* Lenovo [DAOS Solution Guide](https://lenovopress.lenovo.com/lp1421-designing-daos-storage-solutions-with-sr630-v2)
* Lenovo [SR630v2 Product Guide](https://lenovopress.lenovo.com/lp1391-thinksystem-sr630-v2-server)

DAOS storage software references:

* DAOS [github repository](https://github.com/daos-stack/daos)
* DAOS [packages repository](https://packages.daos.io/v2.6.4/)
* DAOS [documentation](https://docs.daos.io/)
* [SC-Asia 2020 paper](https://doi.org/10.1007/978-3-030-48842-0_3)
  _DAOS: A Scale-Out High Performance Storage Stack for Storage Class Memory_
* [SC-Asia 2023 paper](https://doi.org/10.1145/3581576.3581577)
  _Understanding DAOS Storage Performance Scalability_


## Client Nodes

The DAOS clients in LRZ's SuperMUC-NG Phase2 system are 
Lenovo ThinkSystem SD650-I V3 Neptune DWC servers,
currently running DAOS Version 2.6.4-2 on SLES 15.5:

* 2x Intel Xeon Platinum 8480L CPU @ 2.0GHz (56 cores)
* 4x Intel Data Center GPU Max 1550 128GB 600Watt
* 16x 32GiB TruDDR5 Memory (4800MT)
* 2x Mellanox ConnectX-6 1-port InfiniBand HDR adapter (DWC)

Reference information for the DAOS clients:

* Lenovo [SD650-I v3 Product Guide](https://lenovopress.lenovo.com/lp1602-thinksystem-sd650-i-v3-server)


## High-Performance Fabric

The HPC Fabric is a fully non-blocking 2-stage HDR InfiniBand network, using
[Mellanox QM8790 Quantum](https://network.nvidia.com/related-docs/prod_ib_switch_systems/PB_QM8790.pdf)
switches (as Edge Switches and as Core Switches).

Both servers and clients use two single-port Mellanox ConnectX-6 HDR adapters (one per CPU socket).
On the servers, each port is managed by a dedicated `daos_engine` running on that CPU socket.
On the clients, each MPI task is communicating through the IB interface on the same NUMA node.


## Execution Environment

All servers and clients were installed with the following software stack:

* [SLES 15.5](https://www.suse.com/releasenotes/x86_64/SUSE-SLES/15-SP5/)
  (kernel version 5.14.21-150500.55.65-default)
* [MLNX\_OFED\_LINUX-23.04-1.1.3.0](https://docs.nvidia.com/networking/display/MLNXOFEDv23041130/Release+Notes)
* [DAOS 2.6.4-2](https://packages.daos.io/v2.6.4/)
* [MPICH-4.1.1](https://www.mpich.org/downloads/)

The following DAOS server and client configuration files were used.
These represent the production-level setup of the storage system:

### DAOS Server configuration

* [/etc/daos/daos\_server.yml](daos_server.yml)
* [/etc/daos/daos\_control.yml](daos_control.yml)
* [/etc/daos/daos\_agent.yml](daos_agent.yml)
* [/etc/sysctl.d/95-daos-net.conf](95-daos-net.conf)

For the IO500 benchmarks, one storage pool was created that spans all 42 servers,
using the [create-pool.sh](create-pool.sh) script.
In that pool, a DAOS POSIX container was created using the [create-cont.sh](create-cont.sh) script.

### Client environment

LRZ's SuperMUC-NG uses Slurm for resource scheduling.

The IO500 run scripts are included in the IO500 results tarballs.

The rules for the IO500 Production lists require that the storage system has no single point of failure.
So the [io500-sc25.config-template.daos-rf1.ini](io500-sc25.config-template.daos-rf1.ini)
configuration file has been used for Production runs.
It protects against single faults by using 2-Way replication
for metadata and IOR-Hard, and 16+1P Erasure Coding for IOR-Easy.

Submissions to the IO500 Research lists are using an itentical storage system setup,
but since the "no single point of failure" requirement does not apply to the Research list
the [io500-sc25.config-template.daos-rf0.ini](io500-sc25.config-template.daos-rf0.ini)
configuration file has been used for Research runs. This configuration does not use replication
or Erasure Coding to maximize the achievable performance.


## IO500 List Entries

* SuperMUC-NG-Phase2-EC:    [SC25         Production List #??](https://io500.org/list/sc25/io500),
  submission [772](https://io500.org/submissions/view/772)
* SuperMUC-NG-Phase2-10-EC: [SC25 10-Node Production List #??](https://io500.org/list/sc25/ten),
  submission [774](https://io500.org/submissions/view/774)
* SuperMUC-NG-Phase2:       [SC25         Research   List #??](https://io500.org/list/sc25/production),
  submission [773](https://io500.org/submissions/view/773)
* SuperMUC-NG-Phase2-10:    [SC25 10-Node Research   List #??](https://io500.org/list/sc25/ten-production),
  submission [775](https://io500.org/submissions/view/775)

