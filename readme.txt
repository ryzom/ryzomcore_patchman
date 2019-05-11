(Voir egalement l'article ListeDesPorts dans le wiki)

BS   : 49990, 49991(slave) + webPorts: 49970,49971 + L3Ports: 49950,49951
PDBS : NO MORE USED : 49992, 49993(slave) + webPorts: 49972,49973 + L3Ports: 49952,49953
LGS  : L3Ports : 49992, 49993 (slave)
LGSBS (no slave) : 49994 + L3Port : 49995 + webPort : 49972
MFS  : 49980

SU:	50505 (L5 connect, for star network)
	50503 (L3 connect, for P2P networtk)
	49998 (Login service web port)
	49999 (Session manager web port)

--------------------------------------------------------------------------------
PATCHMAN PORTS
--------------

PORT  HOST      WHAT                                TUNNEL INFO
----- --------- ----------------------------------- -------------------------------------------------------------------
44745 ep1.rzl01	rzl01 file deployment network		(tunnel as localhost:44745)
44746 r2linux03	internal file deployment network	(internal)
44747 r2linux03	all internal SPM networks		(internal)
44751 ep1.rzt01	all test SPM networks			(tunnel as localhost:44751) - machine uses 'RZT01 machines' password
44752 ep1.rzl01	all live SPM networks			(tunnel as localhost:44752) - machine uses 'RZL01 machines' password


--------------------------------------------------------------------------------
Used ports for admin:
---------------------

Internal (r2linux03)
Domain			AES	AS	ASWEB
----------------	---------------------
HEAD			46722	46721	46720
DAILY			46702	46701	46700
PRE_PRE_LIVE		46712	46711	46710
DAILY_LAS		46762	46761	46760
LINUXSHARD4		46752	46751	46750
LINUXSHARD7		46772	46771	46770
LINUXSHARD8		46782	46781	46780
LINUXSHARD0		46792	46791	46790
RT			46802	46801	46800

Test 01
Domain			AES	AS	ASWEB
----------------	---------------------
RZT01			46712	46711	46710
// DEMO			46742	46741	46740
// PRE_LIVE		46702	46701	46700

Live 01
Domain			AES	AS	ASWEB
----------------	---------------------
RZL01			46702	46701	46700
BACKUP01		46712	46711	46710
LAS01			46722	46721	46720
	
BASEPORTS:
- RT		51100
- HEAD		51200
- OTHERS	51000

	
-----------------------------------------------------------------------------------
RZL01 (Live)
-----
	BE01	BE02	BE03	FE01	FE02
ANIRO	ani1	ani2	ani3	ani4	ani5
LEANON	lea1	lea2	lea3	lea4	lea5
ARIS	ari1	ari2	ari3	ari4	ari5
CHO	cho1	cho2	cho3	cho4	cho5
RING01	rra1	rra2
RING02	rrb1	rrb2
RING03	
CSR	csr1

ADMIN SERVICE	ep1
UNIFIER		su1
BACKUP_MASTER	pd1
BACKUP_SLAVE	pd2
PD_BACKUP	pd3 pd4

BASEPORTS:
- ANIRO 51000
- LEANON 51100
- ARISPOTLE 51200
- CHO 51300
- RING01 51400
- RING02 51500
- RING03 51600
- CSR 51700


-----------------------------------------------------------------------------------
RZT01 (Test)
-----
	BE01	BE02	BE03	FE01	FE02
ANIRO	ani1	ani2	ani3	ani4	ani5
LEANON	lea1
ARIS	ari1
CHO	cho1
RING01	rra1
RING02	rrb1
RING03	
CSR	ep1

ADMIN SERVICE	ep1
UNIFIER		ep1
BACKUP_MASTER	ep1
BACKUP_SLAVE	
PD_BACKUP	ep1

BASEPORTS:
- ANIRO 51000
- LEANON 51100
- ARISPOTLE 51200
- CHO 51300
- RING01 51400
- RING02 51500
- RING03 51600
- CSR 51700


-----------------------------------------------------------------------------------
PRE_LIVE
--------
	BE01	BE02	BE03	FE01 FE02
ANIRO	
LEANON	
ARIS	

RING01  
RING02  
RING03  

ADMIN SERVICE	
UNIFIER		
BACKUP_MASTER	
BACKUP_SLAVE	

BASEPORTS: 51000

BASEPORTS:
- ML1 53000
- ML2 53100
- ML3 53200
- R1 53300
- R2 53400
- R3 53500


-----------------------------------------------------------------------------------
ATS
---
	BE01	BE02	BE03	FE01 FE02
ANIRO	
LEANON	
ARIS	
RING01	
RING02	
RING03	

ADMIN SERVICE	
UNIFIER		
BACKUP_MASTER	
BACKUP_SLAVE	

BASEPORTS:
- ML1 52000
- ML2 52100
- ML3 52200
-  R1 52300
-  R2 52400
-  R3 52500
- ML4 52600
- ML5 52700
- ML6 52800

-----------------------------------------------------------------------------------
DEMO
----
MAINLAND	
RING		

ADMIN SERVICE	
UNIFIER		
BACKUP_MASTER	

BASEPORTS:
- ML1 54000
- R1 54100

-----------------------------------------------------------------------------------

How to add new shards:
----------------------

1. Update readme.txt with new machines & ports
	- update BASEPORTS
	- update machines allocated to each shard

2. Update shard_ctrl_<domain name>.txt file
	- add 'use' clause to domain
	- add shard names to HomeMainlandNames and Mainlands cfg clauses
	- add 'shard' clauses for the new shards (set ShardId, BasePort, hosts, NSHost and FSListenHost

3. On target EGS machines setup save_shard directoriy trees for ring shards and nfs mounts for mainlands
	- eg /etc/fstab entry for live: rsbk001:/home/nevrax/backup/save_shard  /home/nevrax/live/save_shard nfs wsize=8192,rsize=8192 0 0
	- eg /etc/fstab entry for ats: rsring03:/home/nevrax/ats/save_shard  /home/nevrax/ats/save_shard nfs wsize=8192,rsize=8192 0 0

4. setup database entries for shards
	- add shards to NeL 'shard' table
	- add mainland sessions to ring 'sessions' table

5. stop domain mainlands

6. on patchman terminal 'deploy'

7. cvs commit modified shard_ctrl type files

