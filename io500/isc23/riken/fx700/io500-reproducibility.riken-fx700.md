
# IO500 Reproducibility - ISC23 - Riken - FX700

> The goal of these questions are to demonstrate that your IO500 benchmark execution is valid, can be
> reproduced, and provide additional details of your submitted storage system. Along with the other
> submitted items, the answers to these questions are used to calculate your reproducibility score and
> whether the submission is eligible for the Production or Research list.

## SYSTEM PURPOSE

> Please describe the purpose and general usage of the submitted system. This would include the
> types of typical applications it supports (e.g., defense applications, molecular dynamics,
> benchmarking, system test, systems research), the general use and purpose of the data generated
> by the applications running on it.

The FX700 cloud system operated by RIKEN Center for Computational Science (R-CCS) is based on the same
Fujitsu A64FX CPUs as the [Supercomputer Fugaku](https://www.r-ccs.riken.jp/en/fugaku/about/).
Instead of the [Tofu-D](https://doi.org/10.1109/CLUSTER.2018.00090) torus interconnect of Fugaku,
it uses an InfiniBand EDR network as its HPC interconnect.

* [FUJITSU Supercomputer PRIMEHPC FX700](https://www.fujitsu.com/global/products/computing/servers/supercomputer/)
* [FUJITSU Processor A64FX](https://www.fujitsu.com/global/products/computing/servers/supercomputer/a64fx/)

Riken's FX700 cloud system is available to researchers from RIKEN and across Japan.

## AVAILABILITY

> Please provide the deployment timeframe of the submitted system, or for on-demand cloud
> systems, the general period over which it is deployed and destroyed.
>
> Please describe the availability of the system to users and who are its set of most regular users.

Riken's FX700 cloud system is available to researchers from RIKEN and across Japan.

## STORAGE SYSTEM SOFTWARE

> Please describe the purpose and general usage of the submitted system. This would include the
> types of typical applications it supports (e.g., defense applications, molecular dynamics,
> benchmarking, system test, systems research), the general use and purpose of the data generated
> by the applications running on it.

Riken's FX700 cloud system is available to researchers from RIKEN and across Japan.

The DAOS storage system in particular is supporting co-design activities as part of the
"Fugaku NeXT" feasibility study, which is funded by the Ministry of Education, Culture,
Sports, Science and Technology (MEXT) of Japan.
 
> How is this software available? (e.g., commercially, open-source, not publicly available) Note that if
> the storage software is not open-source or commercially available, then a general description
> would be requested, but this would limit the submission’s reproducibility score.
>
> Can anyone download/purchase this software?
>
> List either product webpage or open-source repo of the exact software used in IO500.

The storage software is Distributed Asynchronous Object Store (DAOS), currently at Version 2.3-105-1.
DAOS is completely open-source:

* DAOS [github repository](https://github.com/daos-stack/daos)
* DAOS [packages repository](https://packages.daos.io/)
* DAOS [documentation](https://docs.daos.io/)
* SC-Asia 2020 paper [DAOS: A Scale-Out High Performance Storage Stack for Storage Class Memory](https://doi.org/10.1007/978-3-030-48842-0_3)
* SC-Asia 2023 paper [Understanding DAOS Storage Performance Scalability](https://doi.org/10.1145/3581576.3581577)
* SC-Asia 2023 paper [Evaluating DAOS Storage on ARM64 Clients](https://doi.org/10.1145/3581576.3581616)

Commercial support for DAOS is available from multiple companies. 
 
> Give any and all additional details of this specific storage deployment: (e.g., type of storage server
> product such IBM ESS or DDN SFA400X2, use of Ext4 or some other file system on each storage
> node, dual connected storage media to storage servers).

The DAOS storage cluster in Riken's FX700 cloud system consists of
1x Intel M50CYP server, currently running DAOS Version 2.3.105-1 on Rocky Linux 8.7:

* 2x Intel Xeon Platinum 8360Y CPU @ 2.20GHz (36 core)
* 16x 64GiB DDR4 Memory
* 16x [128GiB Intel Optane 200 Series Persistent Memory](https://ark.intel.com/content/www/us/en/ark/products/series/203877/intel-optane-persistent-memory-200-series.html)
* 8x [Solidigm/Intel D7-P5500 3.84TB U.2 NVMe SSD](https://www.solidigm.com/content/dam/solidigm/en/site/products/data-center/d7/p5510/documents/d7-p5510-series-product-brief.pdf)
* 2x Mellanox ConnectX-6 1-port InfiniBand **EDR** adapter

Reference information for the storage server:

* Intel Server System [M50CYP](https://www.intel.com/content/www/us/en/products/details/servers/server-systems/server-system-m50cyp/products.html)

## RUNTIME ENVIRONMENT

> State here that you provided all scripts/documentation that would allow someone else to
> reproduce your environment and attempt to achieve a similar IO500 score as the submitted
> system.
>
> NOTE: provide all files/documentation/scripts that would enable a user to build your environment
> and deploy the custom scripts, software, or config files once they have obtained the appropriate
> storage system hardware and software. These may be included into the io500.tgz or into the
> extraCodes upload on the submission form.
> 
> Several examples include:
> 
> * Commands used to set striping information (either for the entire system or for particular
>   directories)
> * File system config and tuning information (or a reason why this is not available due to lack
>   of root access, etc) on each node type (e.g., non-default config parameters on all 3 Lustre
>   MDS, OSS, and client)
> * Any additional scripts utilized that impact IO500 execution beyond the io500 config file. For
>   example, with IBM Spectrum Scale, the output of config, cluster, file system and fileset
>   commands (and possibly even a dump of the configuration if possible). Each file system
>   probably has similar type of config/tuning information that would need to be shared for a
>   user to fully reproduce the environment.

Full reproducibility documentation including the DAOS server configuration files as well as
client-side setup and run scripts is provided in the daos-stack github repository:  
[https://github.com/daos-stack/daos-reproducibility/tree/master/io500/isc23/riken-fx700](https://github.com/daos-stack/daos-reproducibility/tree/master/io500/isc23/riken-fx700)

## FAULT TOLERANCE MECHANISMS

> Does your system have a single point of failure? Please describe all mechanisms provide fault
> tolerance for the submitted storage system. Be specific to your submission, not general storage
> system capabilities.
> 
> * Power
> * Networking (e.g., dual redundant switches)
> * Inter Storage data and metadata server (e.g., active-active servers, client-directed RAID,
>   declustered RAID, erasure-coding, 3-way replication)
> * Intra Storage data and metadata server storage media (e.g., raid5)
> 
> Please list any additional information needed to determine whether this system has a single point
> of failure.

DAOS is a scale-out software-defined storage system.

Hardware redundancy on the individual storage server level includes dual power supplies
(with redundant facility power feeds at the rack PUD level), and dual InfiniBand network interfaces
(typically attached to different InfiniBand leaf switches).
All other redundancy features are provided in software.

The DAOS management service is redundant, with instances running on multiple DAOS servers.
Client access to the management plane is transparently redirected in case that individual DAOS servers fail.
There are no dedicated metadata servers.
Data placement is algorithmic, and declustered across all storage targets.

Contrary to traditional storage systems, a DAOS storage allocation (a DAOS _pool_) does not prescribe
any particular data protection level. It is only a raw storage allocation that is performed by the
storage administrator (or a job prolog).  
Data distribution and data protection is handled at the DAOS _container_ level.
A DAOS pool can host multiple containers, which share the storage allocation
but may employ different data distribution and data protection mechanisms. 

Container management is an end user role and does not require storage administrator intervention.
This means that end users are free to pick the appropriate level of data protection
for each of their datasets, on a per-container or even a per-object level. 
DAOS supports sharding/striping (redundancy factor rf=0), replication (2-way up to 5-way),
and network erasure coding (4+1P, 4+2P, 8+1P, 8+2P, 16+1P, 16+2P, etc.). 

**Regarding the IO500 rules**:

* DAOS submissions for the **Production** list typically use 2-Way replication for metadata and for IOR-Hard,
  and single-parity EC (here, 16+1P) for IOR-Easy,
  in order to satisfy the requirement of “no single point of failure”.
* DAOS submissions for the **Research** list typically use sharding/striping (no data protection) for all tests,
  in order to achieve maximum performance.

Note that these choices are completely user-defined (as part of the API definitions in the IO500.ini file),
and have been executed on the **exact same** storage system configuration without intervention
of a storage administrator.

The DAOS storage system in Riken's FX700 cluster is a single server, which is a single point of failure.
So this DAOS deployment does not qualify as a Production system,
even though the FX700 cluster itself is a production computational resource.

## EXECUTION

> Please provide a description of how the IO500 benchmark was executed, e.g., via system scheduler
> (e.g., SLURM) to run a job on the compute cluster, which initially ran a setup process to configure
> the client and file system, and then started the full benchmark.

Riken's FX700 cloud system uses Slurm for resource scheduling.

Full reproducibility documentation including the DAOS server configuration files as well as
client-side setup and run scripts is provided in the daos-stack github repository:  
[https://github.com/daos-stack/daos-reproducibility/tree/master/io500/isc23/riken/fx700](https://github.com/daos-stack/daos-reproducibility/tree/master/io500/isc23/riken/fx700)

> During the IO500 benchmark execution was the system entirely dedicated to running the
> benchmark or were there other jobs running in the same cluster and storage system?

The FX700 cluster was shared with other jobs during general batch operation, managed by Slurm.
The storage system was dedicated while running the benchmark. 

## CACHING

> Please describe all caching mechanisms in client/server that were utilized during the IO500 run.
> This could include caching in any storage medium (e.g., SSD, RAM).
> 
> A few examples would include:
> 
> * Client data/metadata caching (in Linux page cache or in other memory cache)
> * Client side NVMe read-only data cache
> * Storage server metadata/data caching in RAM
> * Storage controller caching
> * RAID card caching

The DAOS File System (DFS) API that was used for the IO500 runs does not perform any caching.

## DATA SOURCE

> Where is the source of truth of the data stored and later read back in the IO500 benchmark? This
> question relates to whether the submitted system is a burst buffer layered on primary storage or
> primary storage itself.

DAOS is a standalone storage system,
and the DAOS POSIX container used in the IO500 benchmarks is the primary storage.

## TRUST

> Please describe any steps taken to ensure that the results are trustworthy.
> 
> * Did you run the benchmark multiple times and get similar scores?
> * Did you validate the score is below the physical capabilities of the deployed hardware?
> * Did you validate that the data was persistently stored?

All runs have been repeated multiple times to ensure consistency.

All results have been reviewed for plausibility and are reasonable within the hardware performance
boundaries of the server, A64FX clients, and EDR InfiniBand network.

An in-depth performace scaling study of IO500 workloads is also available in the SC-Asia 2023 papers
[Understanding DAOS Storage Performance Scalability](https://doi.org/10.1145/3581576.3581577) for x86\_64 clients,
and [Evaluating DAOS Storage on ARM64 Clients](https://doi.org/10.1145/3581576.3581616) for A64FX clients.

## REPRODUCIBILITY

> Given the 4 possible reproducibility scores listed in the 
> [reproducibility description](https://io500.org/the-lists#reproducibility-scores),
> what score do you believe your submission will be assigned? Please double check the definitions of each
> reproducibility level and ensure you have provided enough information to meet your expected
> score.
> 
> * Undefined
> * Limited
> * Proprietary
> * Fully Reproducible

This submission should be assigned the **Fully Reproducible** score.

