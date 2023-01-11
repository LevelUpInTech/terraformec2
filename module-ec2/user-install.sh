#--- module-ec2/user-install.sh

#!/bin/bash
apt update -y &&
apt install -y nginx
echo "This is nginx server here" > /var/www/html/index.html
systemctl reload nginx