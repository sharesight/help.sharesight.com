module ApplicationConfig
	BASE_URL = 'https://staging-help.sharesight.com'

	module S3
		BUCKET = 'sharesight-help-staging'
		ACCESS_ID = ENV['AWS_DEPLOY_ACCESS_ID']
		SECRET_KEY = ENV['AWS_DEPLOY_SECRET_KEY']
		CLOUDFRONT_DIST_ID = 'EXA3OX5JP2617'
	end
end
