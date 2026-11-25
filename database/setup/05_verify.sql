
Name: Irumva Amani
Student ID: 29765
Group: B
Project Name: Livestock Production and Productivity Analysis System
Course: INSY 8311 - Database Development with PL/SQL



-- 1. PDB exists and is open
SELECT name, open_mode FROM v$pdbs WHERE name = 'TUE_29765_IRUMVA_LIVESTOCK_DB';

-- 2. Admin user default and temporary tablespaces
SELECT username, default_tablespace, temporary_tablespace 
FROM dba_users WHERE username = 'IRUMVA_ADMIN';

-- 3. Tablespaces size, autoextend, maxsize
SELECT tablespace_name, file_name, bytes/1024/1024 AS size_mb, 
       autoextensible, maxbytes/1024/1024 AS max_mb 
FROM dba_data_files 
WHERE tablespace_name IN ('LIVESTOCK_DATA', 'LIVESTOCK_IDX');

SELECT tablespace_name, file_name, bytes/1024/1024 AS size_mb, 
       autoextensible, maxbytes/1024/1024 AS max_mb 
FROM dba_temp_files 
WHERE tablespace_name = 'LIVESTOCK_TEMP';

-- 4. Archive log mode
SELECT LOG_MODE FROM V$DATABASE;
