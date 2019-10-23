# Helpsite
Sharesight user help pages.  **This is a public repository.**

Built with Middleman, Contentful, and Lunr.js search.


### To Run Locally:
 - Setup `CONTENTFUL_*` environment keys as per below.
 - Have Node and Ruby versions installed (see package files).
 - `$ bundle install`
 - `$ yarn install`
 - `$ yarn start`


### To Deploy Locally:
 - Be able to run locally first.
 - Run tests: `$ bundle exec rspec spec`
 - Set `APP_ENV` to either `production` or `staging` with your target; defaults to `staging`.
 - Download from Contentful: `$ bundle exec middleman contentful`
 - Build Static HTML to deploy: `$ bundle exec middleman build --verbose`
 - Deploy with `$ bundle exec middleman s3_sync`
 - See Github Actions workflow for more details.


#### List of Secrets and Environment Variables:
To run locally, something like `.envrc` is suggested.

https://github.com/sharesight/help.sharesight.com/settings/secrets
 - AWS_DEPLOY_ACCESS_ID	- for deploying to AWS S3 on user help_deploy
 - AWS_DEPLOY_SECRET_KEY	- for deploying to AWS S3 on user help_deploy
 - BUGSNAG_API_KEY	– for posting releases to Bugsnag
 - CONTENTFUL_MASTER_TOKEN - for pulling published content from [Contentful]( https://app.contentful.com/spaces/kw7pc879iryd/api/keys)
 - CONTENTFUL_PREVIEW_TOKEN	- for pulling draft content from [Contentful]( https://app.contentful.com/spaces/kw7pc879iryd/api/keys)
 - SLACK_WEBHOOK_URL - for posting into Slack notifications/etc
