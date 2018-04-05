# Helpsite
Sharesight user help pages.  **This is a public repository.**

Built with Middleman, Contentful, and Lunr.js search


## Required Private Environment Variables:

### Contentful:
https://app.contentful.com/spaces/kw7pc879iryd/api/keys
#### Login and create your own personal keys for local usage!
```
CONTENTFUL_MASTER_TOKEN
CONTENTFUL_PREVIEW_TOKEN
```

### For Deploys:
#### Use your personal keys if you must deploy locally.
These are stored securely in Travis for the user `help_deploy`.
```
AWS_DEPLOY_ACCESS_ID=
AWS_DEPLOY_SECRET_KEY=
```

#### Travis Specific Environment:
 - For Travis Build Caching via aws-cli (currently linked to the `travis-ci` user, which is currently shared by both [www] and [help]):
   - AWS_ACCESS_KEY_ID
   - AWS_SECRET_ACCESS_KEY
