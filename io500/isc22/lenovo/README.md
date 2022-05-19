# IO500-ISC22 - Lenovo

Reproducibility information for benchmarks submitted to the ISC22
[IO500](https://io500.org/list/isc22/io500) and
[10-Node](https://io500.org/list/isc22/ten) Lists.


## Institution

[Lenovo HPC&AI Business Unit](https://www.lenovo.com/us/en/servers-storage/solutions/hpc/)

The "Lenox" supercomputer in Lenovo's HPC Innovation Center in Stuttgart, Germany
is a production resource that has been in continuous operation since mid 2015
(see the [June/2015 Top500](https://top500.org/system/178548/)).
It is continuously refreshed to include the latest generation HPC compute nodes,
HPC fabrics, and HPC storage technology.

The “Lenox3” partition on which this IO500-ISC22 submission is based includes
Intel Ice Lake based DAOS servers, as well as Intel Ice Lake based compute nodes.
This partition has been available to Lenox users since September 2021. 

The main Lenox users are Lenovo HPC&AI application specialists worldwide,
Lenovo business partners, as well as Lenovo customers and prospects.

## Storage System

The Ice Lake based DAOS storage cluster in Lenovo's Lenox cluster consists of
6x Lenovo SR630v2 servers, currently running DAOS Version 2.0.2-2 on CentOS 8.4:

* 2x Intel Xeon Platinum 8352Y CPU @ 2.20GHz (32 cores)

* 16x 16GiB TruDDR4 Memory (3200MT)

* 16x [128GiB Intel Optane 200 Series Persistent Memory](https://ark.intel.com/content/www/us/en/ark/products/series/203877/intel-optane-persistent-memory-200-series.html)
* 10x [Intel D7-P5500 3.84TB U.2 NVMe SSD](https://ark.intel.com/content/www/us/en/ark/products/202705/intel-ssd-d7p5500-series-3-84tb-2-5in-pcie-4-0-x4-3d3-tlc.html)

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

The Ice Lake based compute nodes used for the IO500 benchmarks are Lenovo SD630v2 servers:

* 2x Intel Xeon Platinum 8360Y CPU @ 2.x0GHz (36 cores)

* 16x 16GiB TruDDR4 Memory (3200MT)

* 1x Mellanox ConnectX-6 1-port InfiniBand HDR adapter

Reference information for the compute nodes:

* Lenovo [SD630v2 Product Guide](https://lenovopress.lenovo.com/lp1394-thinksystem-sd630-v2-server)


## High-Performance Fabric

The HPC Fabric is a fully non-blocking 2-stage HDR InfiniBand network, using 
[Mellanox QM8790 Quantum](https://network.nvidia.com/related-docs/prod_ib_switch_systems/PB_QM8790.pdf)
switches (as Edge Switches and as Core Switches).

The DAOS servers use two single-port Mellanox ConnectX-6 HDR adapters (one per CPU socket),
and each port is managed by a dedicated `daos_engine` running on that CPU socket.
Compute nodes use a single 1-port ConnectX-6 HDR adapter.


## Execution Environment

All servers and clients were installed with the following software stack:

* [CentOS 8.4](https://wiki.centos.org/Manuals/ReleaseNotes/CentOS8.2105) (kernel version 4.18.0-305.25.1.el8\_4.x86\_64)

* [MLNX\_OFED\_LINUX-5.5-1.0.3.2](https://docs.nvidia.com/networking/display/MLNXOFEDv551032/Release+Notes)

* [DAOS 2.0.2-2](https://packages.daos.io/v2.0.2/CentOS8/)

The following DAOS server and client configuration files were used.
These represent the production-level setup of the storage system:

* [/etc/daos/daos\_server.yml](daos_server.yml)
* [/etc/daos/daos\_control.yml](daos_control.yml)
* [/etc/daos/daos\_agent.yml](daos_agent.yml)
* [/etc/sysctl.d/95-daos-net.conf](95-daos-net.conf)

### Client environment

Lenovo's Lenox cluster uses Slurm for resource scheduling.
The Slurm job control statements for Lenox have been included in
the IO500 run script that is included in the IO500 results tarball.

User environment:

* [/etc/profile.d/daos\_env.mlx.sh](daos_env.mlx.sh)


## IO500 List Entries

Will be cross-referenced after the publication of the IO500-ISC22 list...

