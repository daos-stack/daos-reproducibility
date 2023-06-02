# IO500-ISC23 - LRZ - SuperMUC-NG Phase2

Reproducibility information for benchmarks submitted to the ISC23
[IO500](https://io500.org/list/isc23/io500) and
[10-Node](https://io500.org/list/isc23/ten) Lists.

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
42x Lenovo SR630v2 servers, currently running DAOS Version 2.3.105-1 on SLES 15.4:

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
* DAOS [packages repository](https://packages.daos.io/)
* DAOS [documentation](https://docs.daos.io/)
* [SC-Asia 2020 paper](https://doi.org/10.1007/978-3-030-48842-0_3)
  _DAOS: A Scale-Out High Performance Storage Stack for Storage Class Memory_
* [SC-Asia 2023 paper](https://doi.org/10.1145/3581576.3581577)
  _Understanding DAOS Storage Performance Scalability_


## Client Nodes

At the time the benchmark runs for the IO500-ISC23 list have been performed,
the compute nodes of the SuperMUC-NG Phase2 system had not been deployed yet.
For this reason, some of the DAOS server nodes have been repurposed as client nodes.
Please refer to the previous section for details on the node configuration.

* Full IO500 list (Production and Research): 18 DAOS nodes have been used as DAOS servers, and 24 DAOS nodes have been used as DAOS clients.
* 10-Node list (Production and Research): 32 DAOS nodes have been used as DAOS servers, and 10 DAOS nodes have been used as DAOS clients.


## High-Performance Fabric

The HPC Fabric is a fully non-blocking 2-stage HDR InfiniBand network, using
[Mellanox QM8790 Quantum](https://network.nvidia.com/related-docs/prod_ib_switch_systems/PB_QM8790.pdf)
switches (as Edge Switches and as Core Switches).

Both servers and clients use two single-port Mellanox ConnectX-6 HDR adapters (one per CPU socket).
On the servers, each port is managed by a dedicated `daos_engine` running on that CPU socket.
On the clients, each MPI task is communicating through the IB interface on the same NUMA node.


## Execution Environment

All servers and clients were installed with the following software stack:

* [SLES 15.4](https://www.suse.com/releasenotes/x86_64/SUSE-SLES/15-SP4/) (kernel version 5.14.21-150400.24.33-default)
* [MLNX\_OFED\_LINUX-5.9-0.5.6.0](https://docs.nvidia.com/networking/display/MLNXOFEDv590560/Release+Notes)
* [DAOS 2.3.105-tb](https://github.com/daos-stack/daos/releases/tag/v2.3.105-tb)
* [MPICH-4.1.1](https://www.mpich.org/downloads/)

The following DAOS server and client configuration files were used.
These represent the production-level setup of the storage system:

### DAOS Server configuration

* [/etc/daos/daos\_server.yml](daos_server.yml)
* [/etc/daos/daos\_control.yml](daos_control.yml)
* [/etc/daos/daos\_agent.yml](daos_agent.yml)
* [/etc/sysctl.d/95-daos-net.conf](95-daos-net.conf)

For the IO500 benchmarks, two storage pools were created:

* One pool that spans  [18 servers](create-pool-18srv.sh) for the full list runs,
  using a hostfile for [24 clients](machinefile.24cli-112)
* One pool that spans  [32 servers](create-pool-32srv.sh) for the 10-Node list runs,
  using a hostfile for [10 clients](machinefile.10cli-112)

### Client environment

LRZ's SuperMUC-NG uses Slurm for resource scheduling. However, the IO500-ISC23 runs were performed in the early
deployment stage of the Phase2 installation, before user operation started. For this reason the runs have been
performed with interactive `mpirun` invocations, using a hostlist to specify client nodes as described above.

The IO500 run scripts are included in the IO500 results tarballs.

The rules for the IO500 Production lists require that the storage system has no single point of failure.
So the [io500-isc23.config-template.daos-rf1.ini](io500-isc23.config-template.daos-rf1.ini)
configuration file has been used for Production runs.
It protects against single faults by using 2-Way replication
for metadata and IOR-Hard, and 16+1P Erasure Coding for IOR-Easy.

Submissions to the IO500 Research lists are using an itentical storage system setup,
but since the "no single point of failure" requirement does not apply to the Research list
the [io500-isc23.config-template.daos-rf0.ini](io500-isc23.config-template.daos-rf0.ini)
configuration file has been used for Research runs. This configuration does not use replication
or Erasure Coding to maximize the achievable performance.


## IO500 List Entries

* SuperMUC-NG-Phase2-EC:    [ISC23         Production List  #1](https://io500.org/list/isc23/io500),
  submission [668](https://io500.org/submissions/view/668)
* SuperMUC-NG-Phase2-10-EC: [ISC23 10-Node Production List  #1](https://io500.org/list/isc23/ten),
  submission [669](https://io500.org/submissions/view/669)
* SuperMUC-NG-Phase2:       [ISC23         Research   List #11](https://io500.org/list/isc23/production),
  submission [670](https://io500.org/submissions/view/670)
* SuperMUC-NG-Phase2-10:    [ISC23 10-Node Research   List #10](https://io500.org/list/isc23/ten-production),
  submission [671](https://io500.org/submissions/view/671)

