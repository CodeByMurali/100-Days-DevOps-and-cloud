1. Connect to PostgreSQL
Switch to the postgres system user and access the prompt:

Bash
sudo -u postgres psql
2. Create the User and Database
Run the following SQL commands:

SQL
-- a. Create the database user
CREATE USER kodekloud_aim WITH PASSWORD 'Rc5C9EyvbU';

-- b. Create the database and grant permissions
CREATE DATABASE kodekloud_db5;
GRANT ALL PRIVILEGES ON DATABASE kodekloud_db5 TO kodekloud_aim;
3. Verification
To ensure everything is configured correctly:

List databases: \l

List users: \du
