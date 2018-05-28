bin/magento setup:di:compile  
if [ $? -eq 0 ]; then
    curl -X POST --data-urlencode 'payload={"channel": "#gwa-git", "username": "Deployment '$CODEBUILD_BUILD_ID'", "text": "Compile is sucessfull :green_heart: "}' https://hooks.slack.com/services/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
else
    curl -X POST --data-urlencode 'payload={"channel": "#gwa-git", "username": "Deployment '$CODEBUILD_BUILD_ID'", "text": "Compilation has failed :scream: "}' https://hooks.slack.com/services/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
fi
