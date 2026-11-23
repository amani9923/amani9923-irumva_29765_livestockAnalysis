
 Phase III 
   
Task 2
  


Script   : 02_create_user.sql   
  
Name     : Irumva Amani
  
 StudentID: 29765
  
 Group    : B
  
 Project  : Livestock Production and Productivity Analysis System
  
Course   : INSY 8311 - Database Development with PL/SQL
  
Run as   : SYS AS SYSDBA (the script switches into the PDB)


alter session set container = tue_29765_irumva_livestock_db;

show con_name;

-- Remove the user only if it already exists, so the script can be re-run
begin
  execute immediate 'drop user irumva_admin cascade';
exception
  when others then
    if sqlcode != -1918 then raise; end if;
end;
/

-- Lab-only convention: password = first name. Never do this on a real system.
create user irumva_admin identified by irumva;
grant create session to irumva_admin;
grant dba to irumva_admin;

-- Confirm the user, its status and its DBA role inside the PDB
select lower(sys_context('userenv','con_name')) as pdb_name,
       to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') as run_time
from dual;

select lower(username) as username, account_status
from dba_users where username = 'IRUMVA_ADMIN';

select lower(grantee) as grantee, lower(granted_role) as granted_role
from dba_role_privs where grantee = 'IRUMVA_ADMIN';

-- Connection proof: log in as irumva_admin to the PDB service, then run
--   show user
--   show con_name
-- (SQL*Plus: connect irumva_admin/irumva@localhost:1521/tue_29765_irumva_livestock_db)
