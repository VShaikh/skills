# setup postgres
```shell
sudo apt install postgresql postgresql-contrib
sudo -i -u postgres
psql

CREATE DATABASE accord_db;
CREATE USER accord_user WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE accord_db TO accord_user;
\l

ALTER USER postgres PASSWORD 'postgres';
sudo systemctl status postgresql

```
