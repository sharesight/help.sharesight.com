module ApplicationConfig
	APP_ENV = 'staging'
	BASE_URL = 'https://staging-help.sharesight.com'
	PORTFOLIO_URL = 'https://test-portfolio.sharesight.com'
	MARKETING_URL = 'https://staging-www.sharesight.com'
	COMMUNITY_URL = 'https://test-community.sharesight.com'

	module GoogleAnalytics
		TAG_MANAGER_CONTAINER = 'GTM-P2DH5X'
	end

	module Intercom
		APP_ID = 't2bi7urt'
	end

	module S3
		BUCKET = 'sharesight-help-staging'
		ACCESS_ID = ENV['AWS_ACCESS_KEY_ID']
		SECRET_KEY = ENV['AWS_SECRET_ACCESS_KEY']
		CLOUDFRONT_DIST_ID = 'EXA3OX5JP2617'
	end
end
