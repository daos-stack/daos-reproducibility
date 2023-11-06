
# IO500 Reproducibility - SC23 - LRZ - SuperMUC-NG-Phase2-EC

> The goal of these questions are to demonstrate that your IO500 benchmark execution is valid, can be
> reproduced, and provide additional details of your submitted storage system. Along with the other
> submitted items, the answers to these questions are used to calculate your reproducibility score and
> whether the submission is eligible for the Production or Research list.

## SYSTEM PURPOSE

> Please describe the purpose and general usage of the submitted system. This would include the
> types of typical applications it supports (e.g., defense applications, molecular dynamics,
> benchmarking, system test, systems research), the general use and purpose of the data generated
> by the applications running on it.

SuperMUC-NG is the name of the high-end supercomputer at the Leibniz-Rechenzentrum (Leibniz
Supercomputing Centre) in Garching near Munich (the MUC suffix is borrowed from the Munich airport code).
With more than 311,000 cores and a peak performance of more than 26.9 Petaflop/s
(=10^15 Floating Point Operations per second), it is one of the fastest supercomputers in the world.

SuperMUC-NG is available to all European researchers of the PRACE member states
to expand the frontiers of science and engineering.

SuperMUC-NG Phase2 is the expansion of this supercomputer, which is deployed in 2022/2023.

[https://doku.lrz.de/display/PUBLIC/High+Performance+Computing](https://doku.lrz.de/display/PUBLIC/High+Performance+Computing)

## AVAILABILITY

> Please provide the deployment timeframe of the submitted system, or for on-demand cloud
> systems, the general period over which it is deployed and destroyed.
>
> Please describe the availability of the system to users and who are its set of most regular users.

SuperMUC-NG is available to all European researchers of the PRACE member states
to expand the frontiers of science and engineering.

SuperMUC-NG Phase2 is the expansion of this supercomputer, which is deployed in 2022/2023.

## STORAGE SYSTEM SOFTWARE

> Please describe the purpose and general usage of the submitted system. This would include the
> types of typical applications it supports (e.g., defense applications, molecular dynamics,
> benchmarking, system test, systems research), the general use and purpose of the data generated
> by the applications running on it.

SuperMUC-NG is available to all European researchers of the PRACE member states
to expand the frontiers of science and engineering.

SuperMUC-NG Phase2 is the expansion of this supercomputer, which is deployed in 2022/2023.
 
> How is this software available? (e.g., commercially, open-source, not publicly available) Note that if
> the storage software is not open-source or commercially available, then a general description
> would be requested, but this would limit the submission’s reproducibility score.
>
> Can anyone download/purchase this software?
>
> List either product webpage or open-source repo of the exact software used in IO500.

The storage software is Distributed Asynchronous Object Store (DAOS), currently at Version 2.4.0-2.
DAOS is completely open-source:

* DAOS [github repository](https://github.com/daos-stack/daos)
* DAOS [packages repository](https://packages.daos.io/v2.4.0/)
* DAOS [documentation](https://docs.daos.io/)
* [SC-Asia 2020 paper](https://doi.org/10.1007/978-3-030-48842-0_3)
  _DAOS: A Scale-Out High Performance Storage Stack for Storage Class Memory_
* [SC-Asia 2023 paper](https://doi.org/10.1145/3581576.3581577)
  _Understanding DAOS Storage Performance Scalability_

Commercial support for DAOS is available from multiple companies. 
For SuperMUC-NG Phase2, DAOS support is provided by Lenovo and Intel.
 
> Give any and all additional details of this specific storage deployment: (e.g., type of storage server
> product such IBM ESS or DDN SFA400X2, use of Ext4 or some other file system on each storage
> node, dual connected storage media to storage servers).

The DAOS storage cluster in LRZ's SuperMUC-NG Phase2 system consists of
42x Lenovo SR630v2 servers, currently running DAOS Version 2.4.0-2 on SLES 15.4:

* 2x Intel Xeon Platinum 8352Y CPU @ 2.20GHz
* 16x 32GiB TruDDR4 Memory (3200MT)
* 16x [128GiB Intel Optane 200 Series Persistent Memory](https://ark.intel.com/content/www/us/en/ark/products/series/203877/intel-optane-persistent-memory-200-series.html)
* 8x [Solidigm/Intel D7-P5500 3.84TB U.2 NVMe SSD](https://www.solidigm.com/content/dam/solidigm/en/site/products/data-center/d7/p5510/documents/d7-p5510-series-product-brief.pdf)
* 2x Mellanox ConnectX-6 1-port InfiniBand HDR adapter

Reference information for the storage solution:

* Lenovo [DAOS Solution Guide](https://lenovopress.lenovo.com/lp1421-designing-daos-storage-solutions-with-sr630-v2)
* Lenovo [SR630v2 Product Guide](https://lenovopress.lenovo.com/lp1391-thinksystem-sr630-v2-server)

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
[https://github.com/daos-stack/daos-reproducibility/tree/master/io500/sc23/lrz/sng2](https://github.com/daos-stack/daos-reproducibility/tree/master/io500/sc23/lrz/sng2)

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
The servers used at LRZ are also using memory DIMMs with ECC error detection and correction. 
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

* DAOS submissions for the **Production** list use 2-Way replication for metadata and for IOR-Hard,
  and single-parity EC (here, 16+1P) for IOR-Easy,
  in order to satisfy the requirement of “no single point of failure”.
  The following DAOS object class settings are used in the io500.ini file for the Production list:

```
    [ior-easy]
    API = DFS --dfs.pool=lrz_18srv --dfs.cont=cont01 --dfs.dir_oclass=RP_2G1 --dfs.oclass=EC_16P1GX
    [ior-hard]
    API = DFS --dfs.pool=lrz_18srv --dfs.cont=cont01 --dfs.dir_oclass=RP_2G1 --dfs.oclass=RP_2GX --dfs.chunk_size=470080
    [mdtest-easy]
    API = DFS --dfs.pool=lrz_18srv --dfs.cont=cont01 --dfs.dir_oclass=RP_2GX --dfs.oclass=RP_2G1
    [mdtest-hard]
    API = DFS --dfs.pool=lrz_18srv --dfs.cont=cont01 --dfs.dir_oclass=RP_2GX --dfs.oclass=RP_2G1
```

* DAOS submissions for the **Research** list use sharding/striping (no data protection) for all tests,
  in order to achieve maximum performance.
  The following DAOS object class settings are used in the io500.ini file for the Research list:

```
    [ior-easy]
    API = DFS --dfs.pool=lrz_42srv --dfs.cont=cont01 --dfs.dir_oclass=S1 --dfs.oclass=SX
    [ior-hard]
    API = DFS --dfs.pool=lrz_42srv --dfs.cont=cont01 --dfs.dir_oclass=S1 --dfs.oclass=SX --dfs.chunk_size=470080
    [mdtest-easy]
    API = DFS --dfs.pool=lrz_42srv --dfs.cont=cont01 --dfs.dir_oclass=SX --dfs.oclass=S1
    [mdtest-hard]
    API = DFS --dfs.pool=lrz_42srv --dfs.cont=cont01 --dfs.dir_oclass=SX --dfs.oclass=S1
```

Note that these choices are completely user-defined (as part of the API definitions in the IO500.ini file),
and have been executed on the **exact same** storage system configuration without intervention
of a storage administrator.

## EXECUTION

> Please provide a description of how the IO500 benchmark was executed, e.g., via system scheduler
> (e.g., SLURM) to run a job on the compute cluster, which initially ran a setup process to configure
> the client and file system, and then started the full benchmark.

LRZ's SuperMUC-NG uses Slurm for resource scheduling. However, the IO500-ISC23 runs were performed in the 
deployment stage of the Phase2 installation, before user operation started. For this reason the runs have been
performed with interactive `mpirun` invocations, using a hostlist to specify client nodes.

Full reproducibility documentation including the DAOS server configuration files as well as
client-side setup and run scripts is provided in the daos-stack github repository:  
[https://github.com/daos-stack/daos-reproducibility/tree/master/io500/sc23/lrz/sng2](https://github.com/daos-stack/daos-reproducibility/tree/master/io500/sc23/lrz/sng2)

> During the IO500 benchmark execution was the system entirely dedicated to running the
> benchmark or were there other jobs running in the same cluster and storage system?

Compute nodes and storage system were dedicated while running the benchmark.

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
boundaries of the servers, clients, and HDR InfiniBand network.

An in-depth performace sclaing study of IO500 workloads is also available in the
[SC-Asia 2023 paper](https://doi.org/10.1145/3581576.3581577)
_Understanding DAOS Storage Performance Scalability_.

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

