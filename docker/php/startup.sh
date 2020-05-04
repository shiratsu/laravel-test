#!/bin/bash
chown ec2-user:ec2-user -R /home/ec2-user/public_html
chmod 705 /home/ec2-user

/sbin/service crond start
/sbin/service httpd start

# /etc/rc.d/init.d/sshd start

while true
do
    sleep 5
done

php artisan $1