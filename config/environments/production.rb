module ApplicationConfig
  APP_ENV = 'production'
  BASE_URL = 'https://help.sharesight.com'
  PORTFOLIO_URL = 'https://portfolio.sharesight.com'
  MARKETING_URL = 'https://www.sharesight.com'
  COMMUNITY_URL = 'https://community.sharesight.com'

  module GoogleAnalytics
    TAG_MANAGER_CONTAINER = 'GTM-5HSWD9'
  end

  module Intercom
		APP_ID = 'tv6jsyee'
	end

  module S3
    BUCKET = 'sharesight-help'
		ACCESS_ID = ENV['AWS_ACCESS_KEY_ID']
		SECRET_KEY = ENV['AWS_SECRET_ACCESS_KEY']
		SESSION_TOKEN = ENV['AWS_SESSION_TOKEN']
    CLOUDFRONT_DIST_ID = 'E1BFZMZ0P2YA59'
  end
end
