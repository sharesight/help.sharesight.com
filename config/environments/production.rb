module ApplicationConfig
  APP_ENV = 'production'
  BASE_URL = 'https://help.sharesight.com'
  PORTFOLIO_URL = 'https://portfolio.sharesight.com'
  MARKETING_URL = 'https://www.sharesight.com'
  COMMUNITY_URL = 'https://community.sharesight.com'

  module GoogleAnalytics
    TAG_MANAGER_CONTAINER = 'GTM-5HSWD9'
  end

  module Bugsnag
    API_KEY = ENV['BUGSNAG_API_KEY']
  end

  module Intercom
		APP_ID = 'tv6jsyee'
	end

  module Optimizely
		ID = 5841851301
	end

  module S3
    BUCKET = 'sharesight-help'
    ACCESS_ID = ENV['AWS_DEPLOY_ACCESS_ID']
    SECRET_KEY = ENV['AWS_DEPLOY_SECRET_KEY']
    CLOUDFRONT_DIST_ID = 'E1BFZMZ0P2YA59'
  end
end
