# How To Build Helpsite

1. `git clone git@github.com:sharesight/help.sharesight.com.git`
2. Setup your environment, see `../README.md`
3. Make some changes…
4. `middleman contentful && middleman build`
5. Create a PR, your code will be built in CI
6. When ready for QA, merge your PR branch to develop. It will build and if
   there were no errors, deploy `develop` to the staging site at
   http://sharesight-help-staging.s3-website-us-east-1.amazonaws.com/
7. When QA is done and PR is reviewed, merge the PR to master. Build and deploy
   will be handled by CI/CD.
