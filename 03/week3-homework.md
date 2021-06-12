# Week 3 Homework

### Steps
- [x] Deploy `single-template` component from `website` stack.  
Done with script: [`deploy-single-template.sh`](deploy-single-template.sh).  
Result: [`deploy.log`](deploy.log)
- [x] Fetch stack outputs.  
Done with script: [`display-stack-outputs.sh`](display-stack-outputs.sh).  
Result: [`stack_outputs.yml`](stack_outputs.yml)
- [x] Fetched stack events log.  
Done with command `aws cloudformation describe-stack-events --stack-name website-single-template-website-dev --output yaml > stack-events.yml`.  
 Result: [`stack-events.yml`](stack-events.yml)
- [x] Upload website content.  
Done with command: `aws s3 sync . s3://website-single-template-website-dev-s3website-169yyhm8d7sc4`  
Result: [`content-upload.log`](content-upload.log)

### Final result
http://website-single-template-website-dev-s3website-169yyhm8d7sc4.s3-website.eu-central-1.amazonaws.com