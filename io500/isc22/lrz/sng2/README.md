# IO500-ISC22 - LRZ - SuperMUC-NG Phase2

Reproducibility information for benchmarks submitted to the ISC22
[IO500](https://io500.org/list/isc22/io500) and
[10-Node](https://io500.org/list/isc22/ten) Lists.


## Institution

[LRZ](https://www.lrz.de/)

This supercomputer is Phase Two of LRZ's
[SuperMUC-NG](https://doku.lrz.de/pages/viewpage.action?pageId=64815239).


## Storage System

The DAOS storage cluster in LRZ's SuperMUC-NG Phase2 system consists of
42x Lenovo SR630v2 servers, currently running DAOS Version 2.0.2-2 on SLES 15.3:

* 2x Intel Xeon Platinum 8352Y CPU @ 2.20GHz

* 16x 32GiB TruDDR4 Memory (3200MT)

* 16x [128GiB Intel Optane 200 Series Persistent Memory](https://ark.intel.com/content/www/us/en/ark/products/series/203877/intel-optane-persistent-memory-200-series.html)
* 8x [Intel D7-P5500 3.84TB U.2 NVMe SSD](https://ark.intel.com/content/www/us/en/ark/products/202705/intel-ssd-d7p5500-series-3-84tb-2-5in-pcie-4-0-x4-3d3-tlc.html)

* 2x Mellanox ConnectX-6 1-port InfiniBand HDR adapter

Reference information for the storage solution:

* Lenovo [DAOS Solution Guide](https://lenovopress.lenovo.com/lp1421-designing-daos-storage-solutions-with-sr630-v2)

* Lenovo [SR630v2 Product Guide](https://lenovopress.lenovo.com/lp1391-thinksystem-sr630-v2-server)

DAOS storage software references:

* DAOS [github repository](https://github.com/daos-stack/daos)

* DAOS [packages repository](https://packages.daos.io/v2.0/)

* DAOS [documentation](https://docs.daos.io/v2.0/)

* DAOS [SC-Asia 2020 paper](https://doi.org/10.1007/978-3-030-48842-0_3)


## Client Nodes

At the time the benchmark runs for the IO500-ISC22 list have been performed,
the compute nodes of the SuperMUC-NG Phase2 system had not been deployed yet.
For this reason, some of the DAOS server nodes have been repurposed as client nodes.
Please refer to the previous section for details on the node configuration.

* Full IO500 list: 20 DAOS nodes have been used as DAOS servers, and 20 DAOS nodes have been used as DAOS clients.

* 10-Node list: 30 DAOS nodes have been used as DAOS servers, and 10 DAOS nodes have been used as DAOS clients.


## High-Performance Fabric

The HPC Fabric is a fully non-blocking 2-stage HDR InfiniBand network, using 
[Mellanox QM8790 Quantum](https://network.nvidia.com/related-docs/prod_ib_switch_systems/PB_QM8790.pdf)
switches (as Edge Switches and as Core Switches).

Both servers and clients use two single-port Mellanox ConnectX-6 HDR adapters (one per CPU socket).
On the servers, each port is managed by a dedicated `daos_engine` running on that CPU socket.
On the clients, each MPI task is communicating through the IB interface on the same NUMA node.


## Execution Environment

All servers and clients were installed with the following software stack:

* [SLES 15.3](https://www.suse.com/releasenotes/x86_64/SUSE-SLES/15-SP3/) (kernel version 5.3.18-57-default)

* [MLNX\_OFED\_LINUX-5.5-1.0.3.2](https://docs.nvidia.com/networking/display/MLNXOFEDv551032/Release+Notes)

* [DAOS 2.0.2-2](https://packages.daos.io/v2.0.2/Leap15/packages/x86_64/)

The following DAOS server and client configuration files were used.
With the exception of the separation of the DAOS nodes into servers and clients
(because the Phase2 compute nodes had not yet been deployed at the time of the benchmark runs),
these represent the production-level setup of the storage system:

### DAOS configuration for the main IO500 list

* [/etc/daos/daos\_server.yml](daos_server.yml)
* [/etc/daos/daos\_control.yml](daos_control.20srv.yml)
* [/etc/daos/daos\_agent.yml](daos_agent.yml)
* [/etc/sysctl.d/95-daos-net.conf](95-daos-net.conf)

### DAOS configuration for the 10-Node list

* [/etc/daos/daos\_server.yml](daos_server.yml)
* [/etc/daos/daos\_control.yml](daos_control.30srv.yml)
* [/etc/daos/daos\_agent.yml](daos_agent.yml)
* [/etc/sysctl.d/95-daos-net.conf](95-daos-net.conf)

### Client environment

LRZ's SuperMUC-NG uses Slurm for resource scheduling. However, the IO500-ISC22 runs were performed in the early
deployment stage of the Phase2 installation, before user operation started. For this reason the runs have been
performed with interactive `mpirun` invocations, using a hostlist to specify client nodes.

User environment:

* [/etc/profile.d/daos\_env.mlx.sh](daos_env.mlx.sh)

The IO500 run script is included in the IO500 results tarball.


## IO500 List Entries

* SuperMUC-NG Phase2 [IO500 ISC22 #8](https://io500.org/submissions/view/596)

* SuperMUC-NG Phase2 [10-Node ISC22 #6](https://io500.org/submissions/view/614)

