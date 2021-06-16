
BASEPORTS
5X000 to 5X999 where X is the domain ID base
ADMIN
467X0, 467X1, 467X2 where X is the domain ID base
NS
50XXX where XXX is the shard ID for the NS (excl. 50503 and 50505)
FES
47YXX where Y is the domain ID base, as available
SBS
48YXX where Y is the domain ID base, FES port + 1000

49XXX to 50XXX as follows
-------------------------------------------------------------

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
44745 example   example file deployment network     (tunnel as localhost:44745)
44751 example   all test SPM networks               (tunnel as localhost:44751) - machine uses 'example machines' password


-----------------------------------------------------------------------------------
Used ports for admin:
-------------------------------------
Domain          AES     AS      ASWEB
-------------------------------------
EXAMPLE         46762   46761   46760


-----------------------------------------------------------------------------------
EXAMPLE
---
BASEPORTS:
- UNI 56000
- ML1 56100
- ML2 56200
-  R1 56300
-  R2 56400
-  R3 56500
- ML3 56600
- ML4 56700
- ML5 56800
- CSR 56900
FES BASE PORTS:
RING01: 47610
RING02: 47620
ML1: 47670
ML2: 47680
CSR: 47690
