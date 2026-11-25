



SELECT LOG_MODE FROM V$DATABASE;


--EXPLANATION OF CDB vs PDB SCOPE:
--Archive logging is a Container Database (CDB) setting, not a Pluggable Database (PDB) setting.
--A PDB is just a collection of data files plugged into the CDB. 
--Because the CDB manages all background processes and redo logs, you cannot enable or disable archive logging for just one PDB. 
--Enabling it requires shutting down and restarting the entire CDB in MOUNT state, which affects all PDBs.


-- LOCAL INSTALLATION ONLY (Do not run on shared lab server):
-- SHUTDOWN IMMEDIATE;
-- STARTUP MOUNT;
-- ALTER DATABASE ARCHIVELOG;
-- ALTER DATABASE OPEN;
