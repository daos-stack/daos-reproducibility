
# IO500 Reproducibility - SC25 - Institution - System

> The goals of these questions are to demonstrate that your IO500 benchmark execution is valid, can be
> reproduced, and to provide additional details of your submitted storage system. Along with the other
> submitted items, the answers to these questions are used to calculate your reproducibility score and
> whether the submission is eligible for the Production list or Research list.

## SYSTEM PURPOSE

> Please describe the purpose and general usage of the submitted system. This would include the
> types of typical applications it supports (e.g., defense applications, molecular dynamics,
> benchmarking, system test, systems research), and the general use and purpose of the data generated
> by the applications running on it.

## AVAILABILITY

> Please provide the deployment timeframe of the submitted system, or for on-demand cloud
> systems, the general period over which it is deployed and destroyed.

> Please describe the availability of the system to users and who are its set of most regular users.

## STORAGE SYSTEM SOFTWARE

> How is this storage software available? (e.g., commercially, open-source, not publicly available)
> Note that if the storage software is not open-source or commercially available, then a general
> description would be requested, but this would limit the submission’s reproducibility score.

> Can anyone download/purchase this software?
 
> List either product webpage or open-source repo of the exact software used in IO500.
 
> Give any and all additional details of this specific storage deployment: (e.g., type of storage server
> product such IBM ESS or DDN SFA400X2, use of Ext4 or some other file system on each storage
> node, dual connected storage media to storage servers).

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
>   of root access, etc) on each node type (e.g., non-default config parameters on all three
>   types of Lustre nodes: MDS, OSS, and client)
> * Any additional scripts utilized that impact IO500 execution beyond the io500 config file.
>   For example, with IBM Spectrum Scale, the output of mmlsconfig, mmlscluster, mmlsfs and
>   mmfileset commands (and possibly even a dump of the configuration if possible).
>   Each file system probably has similar type of config/tuning information that would need to
>   be shared for a user to fully reproduce the environment.

## FAULT TOLERANCE MECHANISMS

> Does your system have a single point of failure as defined by `Definition 7` of a Production System?
> Please describe all mechanisms that provide fault
> tolerance for the submitted storage system. Be specific to your submission, not general storage
> system capabilities.
> 
> * Power (For example, can power failure of a node or rack bring down the storage system?)
> * Networking (For example, can failure of a single NIC bring down the storage system?
>   Remember that any networking failure that brings down multiple nodes is acceptable)
> * Inter storage data and metadata server (For example, what type of data protection mechanism
>   does the storage system use to keep operating during node failures, e.g., active-active servers,
>   client-directed RAID, declustered RAID, erasure-coding, 3-way replication)
> * Intra storage data and metadata server storage media (For example, how does the storage system
>   protect against fiailure of a single storage device within a node, e.g., raid5)
> 
> Please list any additional information needed to determine whether this system has a single point
> of failure.

## EXECUTION

> Please provide a description of how the IO500 benchmark was executed, e.g., via system scheduler
> (e.g., SLURM) to run a job on the compute cluster, which initially ran a setup process to configure
> the client and file system, and then started the full benchmark.
> 
> During the IO500 benchmark execution was the system entirely dedicated to running the
> benchmark or were there other jobs running in the same cluster and storage system?

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

## DATA SOURCE

> Is the submitted system a stand-alone storage system or an acceleration layer in front of another
> storage system that is the source of truth for all application data? This question relates to whether
> the submitted system is a burst buffer layered on primary storage or primary storage itself. 

## TRUST

> Please describe any steps taken to ensure that the results are trustworthy.
> 
> * Did you run the benchmark multiple times and get similar scores?
> * Did you validate the score is below the physical capabilities of the deployed hardware?
> * How did you validate that the storage system follows the IO500 rules regarding persistence,
>   which states, "All data must be written to persistent storage within the measured time for the
>   individual benchmark, e.g. if a file system caches data, it must ensure that data is persistently
>   stored before acknowledging the close"?

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

## FEEDBACK

> Please provide feedback on this questionnaire. For example:
>
> *  What additional questions would you like to see?
> *  Were there reasons why you couldn’t complete certain questions?
> *  Would you like to change certain questions?

