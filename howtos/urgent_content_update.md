# Urgent Content Update

If there's an urgent content fix, just create an empty commit on `help.sharesight.com/master` like this:

`git commit --allow-empty -m "Force helpsite build" && git push`

Travis-CI will then rebuild the site (pulling the latest info from Contentful) and push it to the S3 bucket.

Expect cloudfront caches of the old content to remain around a little while (up to a couple of hours some times). To confirm your changes are there, check the direct link to the S3 bucket: http://sharesight-help.s3-website-us-east-1.amazonaws.com/


# Force Sync

If you need to ensure all files are pushed to S3 (not just those that have
  changed), add `FORCE_SYNC` to your commit message. The travis script looks for
  that string and if it's present it will append "--force" to the `middleman s3_sync`
  command, telling it to push all files and not just updates.

E.g.
`git commit --allow-empty -m "FORCE_SYNC rebuild helpsite" && git push`
