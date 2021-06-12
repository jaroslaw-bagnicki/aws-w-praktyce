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
- [ ] Upload website content.