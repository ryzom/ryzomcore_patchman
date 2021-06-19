# Port Assignment

Automatic port allocation starts from the bottom of the port range. Manually allocated ports start from the back.

Ports 49152-65535 may not be used, since they conflict with outgoing connections on Windows, and the shard will fail to launch.

X is the shortened domain identifier, Y is a shortened shard identifier, ZZZ is the full shard identifier.

| Service | From | To |
| --- | --- | --- |
| Shard Services | 3XY00 | 3XY99 |
| BS | 43000 | 43999 |
| Patchman Services | 44000 | 44999 |
| NS | 45ZZZ | |
| Domain Services | 46X00 | 46X99 |
| FES | 47XY0 | 47XY9 |
| SBS | 48XY0 | 48XY9 |

| Service | Port | Development |
| --- | --- | --- |
| NS | 45ZZZ | 45901, 45911 |
| AS Web | 46X99 | 46999 |
| AS | 46X98 | 46998 |
| AES | 46X97 | 46997 |
| SU L5 | 50505 |
| SU L3 | 46X95 | 46995 |
| RSM | 46X94 | 46994 |
| LS | 46X93 | 46993 |
| MFS Fwd | 46X92 | 46991 |
| MFS | 49980 | |
| L3 Master BS | 43950 | |
| L3 Slave BS | 43951 | |
| BS | 49990 | |
| PDBS | 49991 | |
| L3 Master LGS | 43992 | |
| L3 Slave LGS | 43993 | |
| LGS BS | 43994 | |
| L3 LGS BS | 43995 | |
| Patchman SPM Files | 44749 | |
| Patchman Bridge | 44745 | |
| Patchman SPM Commands | 44752 | |

| Domain | Identifier | Short Identifier |
| --- | --- | --- |
| Development | 90 | 9 |
| Production | 60 | 6 |

| Domain | Shard | Identifier | Short Identifier |
| --- | --- | --- | --- |
| Development | Unifier | 900 | 0 |
| Development | Mainland | 901 | 1 |
| Development | Ring | 911 | 3 |
| Production | Unifier | 600 | 0 |
| Production | Mainland 1 | 601 | 1 |
| Production | Mainland 2 | 602 | 2 |
| Production | Ring 1 | 611 | 3 |
| Production | Ring 2 | 612 | 4 |
| Production | CSR | 699 | 9 |

shard_ctrl_definitions.txt: Contains all macros for various shard services and shard configurations.

shard_ctrl_dev.txt: Example configuration for a development domain with a single mainland and a single ring shard running on one machine.

terminal_dev: Contains the terminal to control the patch managers of the dev domain. This is used by the pipeline scripts.

shard_ctrl_prod.txt: Example configuration for a production domain with multiple shards.

terminal_prod: Contains the terminal to control the patch managers of the prod domain.

default: Contains base configuration files of the services containing per-service non-domain non-shard specific values.

cfg: Contains base configuration files with domain and shard type specific values.

admin_install: Contains the scripts to launch the patch manager and the shard. This directory is built into admin_install.tgz by the build pipeline. Subdirectory patchman requires addition of the ryzom_patchman_service executable on the server, the build pipeline adds this file into the tgz archive automatically, do not add it manually. The patchman_service_local.cfg file must be installed manually per server to contain the hostname of the server. The contents of the admin_install.tgz must be installed manually to the server the first time a server is deployed. The working directory is assumed to be /home/nevrax, which will contain /home/nevrax/bin and /home/nevrax/patchman. The configurations under patchman must be modified to match your own domains. Launch /home/nevrax/bin/startup to launch the patchman services. Run '/home/nevrax/bin/admin stop' to stop the patchman services. There is one bridge server, which is tied to one domain, but is used by the other domains as well. The bridge server has a folder /home/nevrax/bridge_server, which is generated by the build pipeline when creating a new server patch.