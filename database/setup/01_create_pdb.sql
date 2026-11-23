
Phase III  

  Task 1


Script   : 01_create_pdb.sql  

 Name     : Irumva Amani

 StudentID: 29765

Group    : B

 Project  : Livestock Production and Productivity Analysis System

 Course   : INSY 8311 - Database Development with PL/SQL

 Run as   : SYS AS SYSDBA, connected to CDB$ROOT



SHOW CON_NAME;

CREATE PLUGGABLE DATABASE tue_29765_irumva_livestock_db
  ADMIN USER pdb_bootstrap IDENTIFIED BY "Boot#Strap2026"
  FILE_NAME_CONVERT = (
    'C:\ORACLE\ORADATA\ORCL\PDBSEED\',
    'C:\ORACLE\ORADATA\ORCL\tue_29765_irumva_livestock_db\');

ALTER PLUGGABLE DATABASE tue_29765_irumva_livestock_db OPEN;
ALTER PLUGGABLE DATABASE tue_29765_irumva_livestock_db SAVE STATE;

SHOW PDBS;
SELECT con_name, state FROM dba_pdb_saved_states;
