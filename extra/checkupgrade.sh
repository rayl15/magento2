#!/bin/bash
bin/magento setup:db:status && UPGRADE_NEEDED=0 || UPGRADE_NEEDED=1
if [[ 1 == ${UPGRADE_NEEDED} ]]; then
    curl -X POST --data-urlencode 'payload={"channel": "#webtest", "username": "Deployment '$CODEBUILD_BUILD_ID'", "text": "DB upgrade is required. Upgrading DB :green_heart: "}' https://hooks.slack.com/services/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
  	bin/magento maintenance:enable
  	bin/magento setup:upgrade --keep-generated
    bin/magento maintenance:disable 
else
    curl -X POST --data-urlencode 'payload={"channel": "#webtest", "username": "Deployment '$CODEBUILD_BUILD_ID'", "text": "DB upgrade is *NOT* required :green_heart: "}' https://hooks.slack.com/services/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     
fi
