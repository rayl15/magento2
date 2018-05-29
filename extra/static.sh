bin/magento setup:static-content:deploy -j 1
if [ $? -eq 0 ]; then
    curl -X POST --data-urlencode 'payload={"channel": "#webtest", "username": "Deployment '$CODEBUILD_BUILD_ID'", "text": "Static Content Deploy :green_heart: "}' https://hooks.slack.com/services/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
else
    curl -X POST --data-urlencode 'payload={"channel": "#webtest", "username": "Deployment '$CODEBUILD_BUILD_ID'", "text": "Static content deploy need some check :scream: "}' https://hooks.slack.com/services/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
fi
