# Week 3 Homework

Done steps
1. Installed `jq` util.
2. Deployed `single-template` component from `website` stack to `eu-central-1` region with [`deploy-single-template.sh`](deploy-single-template.sh) script: [`deploy.log`](deploy.log)
3. Fetched deploy outputs with [`display-stack-outputs.sh`](display-stack-outputs.sh) scripts: [`stack_outputs.yml`](stack_outputs.yml)
4. Fetched stack events log with `aws cloudformation describe-stack-events --stack-name website-single-template-website-dev --output yaml > stack-events.yml` command: [`stack-events.yml`](stack-events.yml)