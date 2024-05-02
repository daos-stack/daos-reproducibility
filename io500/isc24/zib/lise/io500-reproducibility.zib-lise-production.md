
# IO500 Reproducibility - ISC24 - ZIB - NHR System Lise

> The goal of these questions are to demonstrate that your IO500 benchmark execution is valid, can be
> reproduced, and provide additional details of your submitted storage system. Along with the other
> submitted items, the answers to these questions are used to calculate your reproducibility score and
> whether the submission is eligible for the Production or Research list.

## SYSTEM PURPOSE

> Please describe the purpose and general usage of the submitted system. This would include the
> types of typical applications it supports (e.g., defense applications, molecular dynamics,
> benchmarking, system test, systems research), the general use and purpose of the data generated
> by the applications running on it.

The present compute system at NHR@ZIB is system Lise which is named after the physicist Lise Meitner
([https://nhr.zib.de/en/nhr-system-2/](https://nhr.zib.de/en/nhr-system-2/)).
It consists of CPU and GPU partitions, holding more than 120,000 CPU cores, more than 150 GPUs,
and leading to a peak performance of almost 9 Pflop/s.
All compute nodes are attached to global file systems, Home, Work, and archive.
DAOS is available to specific projects only, as it requires a newer OS on the compute nodes
than the standard partitions.

The "Lise" system at ZIB provides HPC services for the German NHR community.

## AVAILABILITY

> Please provide the deployment timeframe of the submitted system, or for on-demand cloud
> systems, the general period over which it is deployed and destroyed.
>
> Please describe the availability of the system to users and who are its set of most regular users.

The [NHR@ZIB center](https://nhr.zib.de/en/) is one of nine NHR centers in the Alliance for
National High Performance Computing (Nationales Hochleistungsrechnen – NHR).
It is a facility of the [Zuse Institute Berlin (ZIB)](https://www.zib.de)
and operates an infrastructure for scientific computing to support science and research throughout Germany.
The scientific board (Wissenschaftlicher Ausschuss) organizes a peer review process to decide about
compute time projects and users are supported by the supra-regional competence network .

## STORAGE SYSTEM SOFTWARE

> Please describe the purpose and general usage of the submitted system. This would include the
> types of typical applications it supports (e.g., defense applications, molecular dynamics,
> benchmarking, system test, systems research), the general use and purpose of the data generated
> by the applications running on it.
>
> How is this software available? (e.g., commercially, open-source, not publicly available) Note that if
> the storage software is not open-source or commercially available, then a general description
> would be requested, but this would limit the submission’s reproducibility score.
>
> Can anyone download/purchase this software?
> 
> List either product webpage or open-source repo of the exact software used in IO500.

The storage software is Distributed Asynchronous Object Store (DAOS), currently at Version 2.4.2-2.
DAOS is completely open-source:

* DAOS [github repository](https://github.com/daos-stack/daos)
* DAOS [packages repository](https://packages.daos.io/v2.4.2/)
* DAOS [website](https://daos.io) and [documentation](https://docs.daos.io/)
* [SC-Asia 2020 paper](https://doi.org/10.1007/978-3-030-48842-0_3)
  _DAOS: A Scale-Out High Performance Storage Stack for Storage Class Memory_
* [SC-Asia 2023 paper](https://doi.org/10.1145/3581576.3581577)
  _Understanding DAOS Storage Performance Scalability_

Commercial support for DAOS is available from multiple companies. 
The Intel DAOS engineering team provides DAOS Level 3 support.

> Give any and all additional details of this specific storage deployment: (e.g., type of storage server
> product such IBM ESS or DDN SFA400X2, use of Ext4 or some other file system on each storage
> node, dual connected storage media to storage servers).

The DAOS storage cluster of the "Lise" system consists of 20 DAOS servers from MEGWARE,
based on the Intel Xeon Cascade Lake platform, currently running DAOS version 2.4.2 on Rocky Linux 8.9:

* 2x Intel Xeon Gold 6240R CPU @ 2.40GHz
* 12x 16GiB DRAM (192 GiB per node)
* 12x [128GiB Intel Optane 100 Series Persistent Memory](https://ark.intel.com/content/www/us/en/ark/products/series/190349/intel-optane-persistent-memory-100-series.html)
* 4x [Intel/Solidigm P4610 (SSDPE2KE064T8) 6.4 TB NVMe disks](https://www.solidigm.de/products/data-center/d7/p4610.html#form=U.2%2015mm&cap=6.4%20TB) per node (80 in total)
* 2x [Omni-Path 100 1-port HFI adapter](https://www.cornelisnetworks.com/solutions/adapters/#list)

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
[https://github.com/daos-stack/daos-reproducibility/tree/master/io500/isc24/zib/lise](https://github.com/daos-stack/daos-reproducibility/tree/master/io500/isc24/zib/lise)

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

The DAOS management service is redundant, with instances running on multiple DAOS servers.
Client access to the management plane is transparently redirected in case that individual DAOS servers fail.
There are no dedicated metadata servers.
Data placement is algorithmic, and declustered across all storage targets.

Contrary to traditional storage systems, a DAOS storage allocation (a DAOS _pool_) does not prescribe
any particular data protection level. It is only a raw storage allocation that is performed by the
storage administrator.  
Data distribution and data protection is handled at the DAOS _container_ level.
A DAOS pool can host multiple containers, which share the storage allocation
but may employ different data distribution and data protection mechanisms. 

Container management is an end user role and does not require storage administrator intervention.
This means that end users are free to pick the appropriate level of data protection
for each of their datasets, on a per-container or even a per-object level. 
DAOS supports sharding/striping (redundancy factor rf=0), replication (2-way up to 5-way),
and network erasure coding (4+1P, 4+2P, 8+1P, 8+2P, 16+1P, 16+2P, etc.). 

DAOS submissions for the IO500 **Production** lists use 2-Way replication for metadata and for IOR-Hard,
and single-parity EC (here, 8+1P) for IOR-Easy,
in order to satisfy the requirement of “no single point of failure”.
The following DAOS object class settings are used in the io500.ini file for the Production list:

```
    [ior-easy]
    API = DFS --dfs.pool=bzinthenne_36engine --dfs.cont=cont01 --dfs.dir_oclass=RP_2G1 --dfs.oclass=EC_8P1GX
    [ior-hard]
    API = DFS --dfs.pool=bzinthenne_36engine --dfs.cont=cont01 --dfs.dir_oclass=RP_2G1 --dfs.oclass=RP_2GX --dfs.chunk_size=470080
    [mdtest-easy]
    API = DFS --dfs.pool=bzinthenne_36engine --dfs.cont=cont01 --dfs.dir_oclass=RP_2GX --dfs.oclass=RP_2G1
    [mdtest-hard]
    API = DFS --dfs.pool=bzinthenne_36engine --dfs.cont=cont01 --dfs.dir_oclass=RP_2GX --dfs.oclass=RP_2G1
```

Note that these choices are completely user-defined (as part of the API definitions in the IO500.ini file).

## EXECUTION

> Please provide a description of how the IO500 benchmark was executed, e.g., via system scheduler
> (e.g., SLURM) to run a job on the compute cluster, which initially ran a setup process to configure
> the client and file system, and then started the full benchmark.

The NHR Lise system uses Slurm for resource scheduling.

Full reproducibility documentation including the DAOS server configuration files as well as
client-side setup and run scripts is provided in the daos-stack github repository:  
[https://github.com/daos-stack/daos-reproducibility/tree/master/io500/isc24/zib/lise](https://github.com/daos-stack/daos-reproducibility/tree/master/io500/isc24/zib/lise)
 
> During the IO500 benchmark execution was the system entirely dedicated to running the
> benchmark or were there other jobs running in the same cluster and storage system?

Compute nodes and storage system were dedicated while running the benchmark.
Other compute jobs were running on the Lise system in parallel to the benchmark.

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
boundaries of the servers, clients, and Omni-Path network.

An in-depth performace scaling study of IO500 workloads is also available in the
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

