
# IO500 Reproducibility - SC23 - ALCF - Aurora

> The goal of these questions are to demonstrate that your IO500 benchmark execution is valid, can be
> reproduced, and provide additional details of your submitted storage system. Along with the other
> submitted items, the answers to these questions are used to calculate your reproducibility score and
> whether the submission is eligible for the Production or Research list.

## SYSTEM PURPOSE

> Please describe the purpose and general usage of the submitted system. This would include the
> types of typical applications it supports (e.g., defense applications, molecular dynamics,
> benchmarking, system test, systems research), the general use and purpose of the data generated
> by the applications running on it.

Aurora is Argonne National Labratory's latest high performance super-computer for open science computing being deployed within the Argonne Leadership Computing Facility (ALCF).
The Argonne Leadership Computing Facility, a U.S. Department of Energy (DOE) Office of Science User Facility located at Argonne National Laboratory, enables breakthroughs in science and engineering by providing supercomputing resources and expertise to the research community.

ALCF computing resources—available to researchers from academia, industry, and government agencies—support large-scale, computationally intensive projects aimed at solving some of the world's most complex and challenging scientific problems. Through awards of supercomputing time and support services, the ALCF enables its users to accelerate the pace of discovery and innovation across disciplines.

Aurora will feature several technological innovations, including a revolutionary I/O system—the Distributed Asynchronous Object Store (DAOS)—to support new types of workloads. Aurora will be built on a future generation of Intel Xeon Scalable processor accelerated by Intel’s Xe compute architecture. Slingshot 11 fabric and HPE Cray EX supercomputer platform will form the backbone of the system. Programming techniques already in use on current systems will apply directly to Aurora. The system will be highly optimized across multiple dimensions that are key to success in simulation, data, and learning applications.

https://www.alcf.anl.gov/aurora

## AVAILABILITY

> Please provide the deployment timeframe of the submitted system, or for on-demand cloud
> systems, the general period over which it is deployed and destroyed.

> Please describe the availability of the system to users and who are its set of most regular users.

Aurora is available to scientific researchers worldwide via three different allocations programs:
  * The Innovative and Novel Computational Impact on Theory and Experiment (INCITE)
  * ASCR Leadership Computing Challenge (ALCC)
  * Director's Discretionary

Aurora is expected to be generally available in 2024/2025.

## STORAGE SYSTEM SOFTWARE

> Please describe the purpose and general usage of the submitted system. This would include the
> types of typical applications it supports (e.g., defense applications, molecular dynamics,
> benchmarking, system test, systems research), the general use and purpose of the data generated
> by the applications running on it.

The Aurora DAOS storage system is available to any user on the Aurora system.
Users are provided storage allocations based on their computing allocation requests.
 
> How is this software available? (e.g., commercially, open-source, not publicly available) Note that if
> the storage software is not open-source or commercially available, then a general description
> would be requested, but this would limit the submission’s reproducibility score.

> Can anyone download/purchase this software?

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

Intel supports DAOS on Aurora as part of the Aurora procurement.

> Give any and all additional details of this specific storage deployment: (e.g., type of storage server
> product such IBM ESS or DDN SFA400X2, use of Ext4 or some other file system on each storage
> node, dual connected storage media to storage servers).

Aurora is built on Intel Coyote Pass platform using 1024 server.
* 2x Intel(R) Xeon(R) Gold 5320 CPU @ 2.20GHz
* 16x 32GB DDR4
* 16x 512GB Intel Optrane 200 DCPM
* 16x 15.3TB Samsung PM1733
* 2x HPE Slingshot NIC

Aurora compute system are Aurora Exascale Compute Blades.
* 2x Intel(R) Xeon(R) CPU Max 9470C
* 6x Intel Data Center GPU Max 
* 16x 64GB DDR5
* 8x HPE Slingshot NIC

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

DAOS is configured to use 80 servers as described above and 10 Aurora compute nodes. DAOS clients will use all 8 NICs provided by each client for a total of 80 client endpoints. The DAOS servers are configured to run 2 IO engines on each server for a total of 160 daos server engines. The underlying storage is configured by the `daos scm prepare` and `daos storage scan` as documented in the DAOS Adminstration Guide.

The code is built with the Intel icc compiler, icc (ICC) 2021.9.0 20230201, and uses the Aurora MPICH MPI pre-release.
The Aurora MPICH is built from the open source [MPICH](https://github.com/pmodels/mpich).

The daos code used in this run is from the commit hash, 9597af34c30be0ea4049e43c16169057227e0527.

The io500 script is executed with these environment variables.
```
export CRT_MRC_ENABLE=1
export FI_CXI_RX_MATCH_MODE=hybrid
export FI_CXI_REQ_BUF_SIZE=8388608
export FI_CXI_OFLOW_BUF_SIZE=8388608
export FI_CXI_REQ_BUF_MIN_POSTED=8
export FI_CXI_DEFAULT_CQ_SIZE=131072
export FI_CXI_CQ_FILL_PERCENT=20
export MPIR_CVAR_BCAST_POSIX_INTRA_ALGORITHM=mpir
export MPIR_CVAR_ALLREDUCE_POSIX_INTRA_ALGORITHM=mpir
export MPIR_CVAR_BARRIER_POSIX_INTRA_ALGORITHM=mpir
export MPIR_CVAR_REDUCE_POSIX_INTRA_ALGORITHM=mpir
export LD_LIBRARY_PATH=/scratchbox/daos/mschaara/install/mpich-52.2/lib/:$LD_LIBRARY_PATH
export PATH=/scratchbox/daos/mschaara/install/mpich-52.2/bin/:$PATH
```

The server YAML file is provided at [daos_server.yml](daos_server.yml).
The io500 configuration is available at
[io500-config-research-10.ini](io500-config-research-10.ini)

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

The Aurora hardware and software storage system is able to provide full fault tolerance at various levels of redundancy depedending on the component.

* Power
  * ALCF has a dual-feed from Commerial and UPS power allowing either feed to fail but the system to continue operating.
  * Storage servers have 2+1 power supplies allowing a single power supply failure on any server, or rack PDU failure.
* Networking
  * Each storage server is connected to two different switches, however, each DAOS engine is connected to a single NIC. If a NIC fails, the IO engine is unreachable and the system must reconstruct from another server.
* Storage
  * Storage data can be distribued across multiple servers based on user selected configurations.
  * Servers datasets are selected based on fault-domain which is based on a server, so configurations that stipulate multiple data stripes, each component is put on a different server.
  * For this test case, no data protection was configured, losing a single server results in data becoming unavailable. The data was configured for a single stripe, full stripe or 32 stripes.

## EXECUTION

> Please provide a description of how the IO500 benchmark was executed, e.g., via system scheduler
> (e.g., SLURM) to run a job on the compute cluster, which initially ran a setup process to configure
> the client and file system, and then started the full benchmark.
> 
> During the IO500 benchmark execution was the system entirely dedicated to running the
> benchmark or were there other jobs running in the same cluster and storage system?

The benchmark was run using the PBS scheduler via an interactive job.
The DAOS storage system and pool was configured prior to the execution and contained no existing data.
The Aurora system was not idle during the io500 run but is in a preproduction environment so the competing workloads for the interconnect would be less than during full production.
No other jobs were utilizing the DAOS storage system.

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

DAOS is a standalone storage system, and the DAOS POSIX container used in the IO500 benchmarks is the primary storage.

## TRUST

> Please describe any steps taken to ensure that the results are trustworthy.
> 
> * Did you run the benchmark multiple times and get similar scores?
> * Did you validate the score is below the physical capabilities of the deployed hardware?
> * Did you validate that the data was persistently stored?

The benchmark was run by Intel DAOS staff who have extensive experience in running and assessing the benchmark.
The benchmark was run a few times with various tuning changes applied to find the optimal performance.
The results for each stage fall below the theoretical peaks for any of the hardware components.
The storage system was *not* shutdown and then restarted to confirm that data was durable, however, DAOS is used in our test system and we have confirmed DAOS is able to store data durably between storage restarts.

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

This submission should be assigned the *Fully Reproducible* score based on the io500 criteria.

