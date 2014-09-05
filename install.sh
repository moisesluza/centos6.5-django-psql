#!/bin/bash

# Script to install python 2.7

yum -y update
yum groupinstall -y 'development tools'

#Installing required pakages for python install
sudo yum install -y zlib-devel bzip2-devel openssl-devel xz-libs wget

#--------------
#Install python
#--------------
wget http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz
xz -d Python-2.7.6.tar.xz
tar -xvf Python-2.7.6.tar
cd Python-2.7.6
# Run the configure:
./configure --prefix=/usr/local
# compile and install it:
make
sudo make altinstall
cd ~

#------------------
#Install setuptools
#------------------
wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz
tar -xvf setuptools-1.4.2.tar.gz
cd setuptools-1.4.2
# Install setuptools using the Python 2.7.6:
sudo /usr/local/bin/python2.7 setup.py install
cd ~

#-------------------------------------------------
# Install pip using the newly installed setuptools:
#-------------------------------------------------
sudo /usr/local/bin/easy_install-2.7 pip

#------------------
#Install virtualenv
#------------------
sudo /usr/local/bin/pip2.7 install virtualenv

#-------------------------
#Install virtualenvwrapper
#-------------------------
#sudo /usr/local/bin/pip2.7 install virtualenvwrapper

#------------------
#installing Psycopg
#(installed inside virtualenv)
#------------------
#installing pakages required for Psycopg
#sudo yum install -y python-devel postgresql-devel
#sudo /usr/local/bin/pip2.7 install psycopg2

#--------------
#Install django (installed inside virtualenv)
#--------------
#sudo /usr/local/bin/pip2.7 install django

#------------------
#Install postgresql
#------------------
cd ~
#exclude the CentOS version of postgres in order to get the most recent version from the project's website
#TODO: find the way to edit the file ex:
#	sudo sed -ibk \
#	    -re "s/[#]*listen_addresses = '.*'(.*)/listen_addresses = '*'\1/" \
#	    /etc/postgresql/9.3/main/postgresql.conf
#	echo "host    all   vagrant   10.0.2.2/32  trust" | sudo tee -a
#		 /etc/postgresql/9.3/main/pg_hba.conf
sudo cp /vagrant/CentOS-Base.repo /etc/yum.repos.d/
sudo curl -O http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
sudo rpm -ivh pgdg-centos93-9.3-1.noarch.rpm
sudo yum install -y postgresql93-server postgresql93-devel
#initialize the database environment
sudo service postgresql-9.3 initdb
#configure it to start at boot up
sudo chkconfig postgresql-9.3 on
#start postgresql service
sudo service postgresql-9.3 start
#TODO: edit Client Authentication on pg_hba.conf file otherwise postgres will use IDEN authentication to login. It must be changed to md5 (password authentication)
#TODO: create postgresql database and user. Ex:
#	su -c 'createdb mycartdb' vagrant
#	su -c 'createuser mycartdbuser...' vagrant
#	su -c "psql -c 'create table a;'" vagrant

#--------------------
#Creating Virtual Env
#--------------------
cd ~/mycart
virtualenv mycartvenv
source mycartvenv/bin/activate
pip install django
pip install psycopg2
pip install south



