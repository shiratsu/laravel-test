#!/bin/bash
chown ec2-user:ec2-user -R /home/ec2-user/public_html
chmod 705 /home/ec2-user

cd /home/ec2-user/public_html/hiratsuka-test
php artisan $1

#/sbin/service crond start
/sbin/service httpd start &

# /etc/rc.d/init.d/sshd start

while true
do
    sleep 5
done