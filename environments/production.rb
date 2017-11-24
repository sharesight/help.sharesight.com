module ApplicationConfig
  BASE_URL = 'https://help.sharesight.com'

  module S3
    BUCKET = 'sharesight-help'
    ACCESS_ID = ENV['AWS_DEPLOY_ACCESS_ID']
    SECRET_KEY = ENV['AWS_DEPLOY_SECRET_KEY']
    CLOUDFRONT_DIST_ID = 'E1BFZMZ0P2YA59'
  end
end
