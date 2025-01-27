source 'https://rubygems.org'

# we still need BigDecimal.new for ActiveSupport 4.x
gem 'bigdecimal', '~> 1.4'

gem 'rake'
gem 'middleman', '~> 3.4.1'
gem 'middleman-livereload'
gem 'middleman-s3_sync'
gem 'middleman-cloudfront', '0.2.1'
gem 'middleman-autoprefixer'
gem 'middleman-minify-html'
gem 'middleman-sprockets'
gem "middleman-es6", git: "https://github.com/vast/middleman-es6"
gem 'uglifier'
gem 'contentful', '~> 2.13.0'
gem "contentful_middleman", '~> 2.1.2'
gem 'middleman-syntax'

# support re-writing in the middleman configuration
gem 'rack-rewrite'
gem 'string-urlize'
gem 'aws-s3'
gem 'middleman-remover'

# support whitelist-sanitizing content (remove script-tags, etc.)
gem 'rails-html-sanitizer'

gem 'stopwords-filter', require: 'stopwords'

# ensure we have secure version
gem 'nokogiri', '>= 1.10.8'

# debugging tools
# gem 'debug'
# gem 'binding_of_caller'

# tests
group :test do
  gem 'capybara'
  gem 'ffi', '~> 1.16.3'
  gem 'selenium-webdriver', '~> 3.0'
  gem 'capybara-selenium'
  gem 'chromedriver-helper' # for headless chrome
  gem 'rspec'
  gem 'guard-rspec', require: false
end
