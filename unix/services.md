## Create systemd / systemctl service for mytube-web-python

```shell
sudo gedit /etc/systemd/system/mytube-web-python.service

[Unit]
Description=Gunicorn daemon for Mytube Web Python
After=network.target

[Service]
User=vahid
Group=vahid
WorkingDirectory=/home/vahid/git/mytube-web-python
ExecStart=/home/vahid/miniconda3/envs/mytube-web/bin/gunicorn --workers 17 -threads 2 --bind 0.0.0.0:9001 -m 007 global.wsgi --log-level warn --access-logfile /var/log/mytube-web-python-access.log --error-logfile /var/log/mytube-web-python-error.log

[Install]
WantedBy=multi-user.target


sudo systemctl daemon-reload
setenforce 0

open port 80 in firewalld
```

## Setup systemd / systemctl commands

```shell
vi /etc/systemd/system/mytubeweb.service

sudo systemctl daemon-reload
sudo systemctl start mytubeweb.service
sudo systemctl stop mytubeweb.service
sudo systemctl status mytubeweb.service
sudo systemctl show mytubeweb.service
```

## Create systemd / systemctl service for Solr

```shell
sudo gedit /etc/systemd/system/solr.service

[Unit]
Description=Solr Service
After=network.target

[Service]
User=vahid
WorkingDirectory=/opt/solr/bin/
PIDFile=/opt/solr/bin/solr-8983.pid
ExecStart=/opt/solr/bin/solr start
ExecStop=/opt/solr/bin/solr stop
StandardOutput = file:/opt/solr/bin/stdout.log

[Install]
WantedBy=multi-user.target


sudo systemctl daemon-reload
setenforce 0

open port 8983 in firewalld

sudo systemctl daemon-reload
sudo systemctl start solr.service
sudo systemctl stop solr.service
sudo systemctl status solr.service
sudo systemctl show solr.service
```

## Create systemd / systemctl service for mytubewe_zio

```shell
sudo gedit /etc/systemd/system/mytubewebz.service

[Unit]
Description=Process for MyTubeWeb ZIO
After=network.target

[Service]
User=root
Group=root
WorkingDirectory=/opt/mytubeweb/bin
ExecStart=/opt/mytubeweb/bin/mytubeweb-zio

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl enable mytubewebz.service
setenforce 0

open port 80 in firewalld
```

## Create systemd / systemctl service for pypi
```shell
conda
conda create -n pypi python=3.12.0 -y
conda activate pypi
python -m pip install --upgrade pip
python -m pip install pypiserver
```

```shell
sudo gedit /etc/systemd/system/pypi.service

[Unit]
Description=Process for PyPi Server
After=network.target

[Service]
User=vahid
Group=vahid
WorkingDirectory=/home/vahid/miniconda3/envs/pypi/bin/
ExecStart=/home/vahid/miniconda3/envs/pypi/bin/pypi-server run -p 8090 ~/.pypi_packages/

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl enable pypi.service

```
