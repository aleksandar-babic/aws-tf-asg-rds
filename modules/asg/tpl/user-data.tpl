#!/bin/bash

set -e

# Setup EFS
mkdir -p ${mount_point}
chown ec2-user:ec2-user ${mount_point}
echo "${dns_name}:/ ${mount_point} nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0" >> /etc/fstab
mount -a -t nfs4

# Setup Docker
rm -f etc/yum.repos.d/docker-ce
yum update -y
yum install -y docker
usermod -a -G docker ec2-user
systemctl start docker
systemctl enable docker

# Setup Wordpress
export WORDPRESS_DB_HOST=${db_ip}
export WORDPRESS_DB_NAME=${db_name}
export WORDPRESS_DB_USER=${db_username}
export WORDPRESS_DB_PASSWORD=$(aws ssm get-parameter --region "${ssm_region}" --name "${ssm_db_password}" --with-decryption --query 'Parameter.Value' --output text)

docker run -p 80:80 -d \
-v /var/www/html:/var/www/html \
-e WORDPRESS_DB_HOST \
-e WORDPRESS_DB_USER \
-e WORDPRESS_DB_PASSWORD \
-e WORDPRESS_DB_NAME \
wordpress:php7.4-apache