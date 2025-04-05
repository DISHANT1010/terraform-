#!/bin/bash

sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl start nginx
sudp systemctl enable nginx

echo "<h1>nginx install while instance is created</h1>" > /var/www/html/index.html