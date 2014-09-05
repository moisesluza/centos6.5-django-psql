#shortcut to initialize vagrant
cd ~/Documents/Emar/centos6.5-django-psql
vagrant up
vagrant ssh
source ~/mycart/mycartvenv/bin/activate
cd ~/mycart/mycartapp
./manage.py runserver 0.0.0.0:3000