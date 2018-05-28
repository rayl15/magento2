#!/bin/bash
DIR="/var/www/html"
MAGENTO_PATH=$DIR"/bin/magento"
MODE="production"

echo "Switching to workdirectory"
cd /var/www/html
if [ $? -eq 0 ]; then
    echo "done"
else
    curl -X POST --data-urlencode 'payload={"channel": "#gwa-git", "username": "Deployment '$DEPLOYMENT_GROUP_NAME'", "text": "Error in switching to workdirectory :scream: "}' https://hooks.slack.com/services/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
fi

sudo rm -rf pub/static/* var/di/* var/generation/* var/cache/* var/page_cache/* var/view_preprocessed/* var/composer_home/cache/*

echo "Copy to location"
echo "===================================="
sudo rsync -avz /opt/deployment/*  /var/www/html/
if [ $? -eq 0 ]; then
    curl -X POST --data-urlencode 'payload={"channel": "#gwa-git", "username": "Deployment '$DEPLOYMENT_GROUP_NAME'", "text": "File Copying to location is successful :green_heart: "}' https://hooks.slack.com/services/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
else
    curl -X POST --data-urlencode 'payload={"channel": "#gwa-git", "username": "Deployment '$DEPLOYMENT_GROUP_NAME'", "text": "File Copying to location is failed :scream: "}' https://hooks.slack.com/services/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
fi


echo "executable permissions"
sudo chmod +x bin/magento
if [ $? -eq 0 ]; then
    echo "done"
else
    curl -X POST --data-urlencode 'payload={"channel": "#gwa-git", "username": "Deployment '$DEPLOYMENT_GROUP_NAME'", "text": "Error in assigning permission to bin/magento :scream: "}' https://hooks.slack.com/services/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
fi


echo "Cache flush"
echo "======================================"
sudo php $MAGENTO_PATH cache:flush
if [ $? -eq 0 ]; then
    curl -X POST --data-urlencode 'payload={"channel": "#gwa-git", "username": "Deployment '$DEPLOYMENT_GROUP_NAME'", "text": "Cache flush is successful :green_heart: "}' https://hooks.slack.com/services/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
else
    curl -X POST --data-urlencode 'payload={"channel": "#gwa-git", "username": "Deployment '$DEPLOYMENT_GROUP_NAME'", "text": "Cache flush is failed :scream: "}' https://hooks.slack.com/services/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
fi

echo "Permissions"
echo "======================================"
sudo find . -type f -exec chown ec2-user:nginx {} \;
sudo find . -type d -exec chown ec2-user:nginx {} \;
sudo find . -type f -exec chmod 644 {} \;
sudo find . -type d -exec chmod 755 {} \;
sudo find ./var -type d -exec chmod 777 {} \;
sudo find ./pub/media -type d -exec chmod 777 {} \;
sudo find ./pub/static -type d -exec chmod 777 {} \;
sudo chmod 777 ./app/etc
sudo chmod 644 ./app/etc/*.xml
sudo chmod u+x bin/magento
sudo chmod -R 777 var/*
sudo chmod -R 777 pub/*

if [ $? -eq 0 ]; then
    curl -X POST --data-urlencode 'payload={"channel": "#gwa-git", "username": "Deployment '$DEPLOYMENT_GROUP_NAME'", "text": "Magento permission setup is successful :green_heart: "}' https://hooks.slack.com/services/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
else
    curl -X POST --data-urlencode 'payload={"channel": "#gwa-git", "username": "Deployment '$DEPLOYMENT_GROUP_NAME'", "text": "Magento permission setup is failed :scream: "}' https://hooks.slack.com/services/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
fi

