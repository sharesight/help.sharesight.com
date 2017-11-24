set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

helpers do

  # locale Helpers
  def locale_cert_type
    locale = current_page.url.split("/")
    if locale.count === 2
      locale_data = data.locale_pages.detect {|x| x.id == locale.last}
      if locale_data
        locale_data["cert_type"].to_s if locale_data["id"] != "usa"
      end
    else
      "stock"
    end
  end

  def help_pages
    data.help_pages.page
  end

  def locale_content(obj)
    en = obj.last.content.en

    #TODO: REFACTOR Me...

    nz = obj.last.content["en-NZ"]
    au = obj.last.content["en-AU"]
    ca = obj.last.content["en-CA"]
    gb = obj.last.content["en-GB"]
    uk = obj.last.content["en-UK"]
    alt_locale = current_alt_locale

    if !au.nil? && alt_locale == 'en-AU'
      au
    elsif !nz.nil? && alt_locale == 'en-NZ'
      nz
    elsif !ca.nil? && alt_locale == 'en-CA'
      ca
    elsif !gb.nil? && alt_locale == 'en-GB'
      gb
    elsif !uk.nil? && alt_locale == 'en-UK'
      uk
    else
      en
    end
  end

  def alternative_locale(obj)
    if obj.id == "GLOBAL"
      "en"
    else
      "en-#{obj.id.upcase.gsub('UK','GB')}"
    end
  end

  def locale_str_correction(obj)
    if obj.id == "GLOBAL"
      ""
    else
      "/#{obj.id.downcase}/"
    end
  end

  def current_alt_locale
    url = current_page.url.split("/")
    if url[1]
      if url[1].length != 2
        "en"
      else
        "en-#{url[1].upcase}"
      end
    end
  end

  def current_locale
    url = current_page.url.split("/")

    # GLOBAL
    if url.length == 0
      ""
    elsif url[1].length == 2
      "/#{url[1]}"
    end
  end

  def page_file_name
    split_words = current_page.path.split('/')
    word_len = split_words.first.length
    return "#{current_page.path.split('/').last}"
  end

  def meta_helper(prop)
    current_locale = current_page.path.split("/").first
    # puts current_locale
    unless current_locale == "patterns"
      current_locale = "usa" unless current_locale.length == 2 #FIXME: this removes meta data for patterns, patterns needs its own meta helper
      # data.locale_pages.find {|x| x[:id] == current_locale}.pages.select {|y| y[:page] == page_file_name}.first[prop]
      # puts page_file_name
      # puts current_page.path.split('/').last
      return "#{prop} | Sharesight #{data.locale_pages.find {|x| x[:id] == current_locale}.country} Help"
    end
  end

end

data.locale_pages.each do |locale|
  config[:data_locale] = locale
end
# Set which environment this build is running on
#
env_name = ENV['APP_ENV'] || 'development'
set :env_name, env_name
require "environments/#{env_name}"
puts "Helpsite Middleman loading for #{env_name} environment."

config[:ios_store_url] = 'https://itunes.apple.com/nz/app/sharesight-reader/id1147841214?mt=8'
config[:google_store_url] = 'https://play.google.com/store/apps/details?id=com.sharesight.reader&hl=en'

locale_name = ENV['LOCALE'] || 'NZ'

config[:get_location_host] = 'https://portfolio.sharesight.com'

set :locale_name, locale_name
set :locale, "en-#{locale_name}"
require "rack/rewrite"
require "helpers/config_helper"
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page "google1decda79799cf179.html", directory_index: false

set :site_name, 'Sharesight'
set :font_dir, 'fonts'
set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'

set :url_root, ApplicationConfig::BASE_URL

#social media
config[:twitter_site_id] = '109123696'
# @environments
if env_name == 'development'
  config[:signup] = 'https://portfolio.sharesight.com/signup'
  config[:login] = 'https://portfolio.sharesight.com/login'
  config[:google_tag_manager] = 'GTM-P2DH5X'
  config[:optimizely] = '5854941356'
  set :url_ss, 'https://staging-www.sharesight.com'
elsif env_name == 'staging'
  config[:signup] = 'https://test-portfolio.sharesight.com/signup'
  config[:login] = 'https://test-portfolio.sharesight.com/login'
  config[:google_tag_manager] = 'GTM-P2DH5X'
  config[:optimizely] = '5854941356'
  set :url_ss, 'https://staging-www.sharesight.com'
elsif env_name == 'production'
  config[:signup] = 'https://portfolio.sharesight.com/signup'
  config[:login] = 'https://portfolio.sharesight.com/login'
  config[:google_tag_manager] = 'GTM-5HSWD9'
  config[:optimizely] = '5841851301'
  set :url_ss, 'https://www.sharesight.com'
end

activate :i18n, :langs => ["en-#{locale_name}"]
activate :syntax, :line_numbers => true

# This section generates the pattern-library based on data/patterns.json
patterns_prefix = 'page_patterns_'
patterns_section_class = 'patterns'

# data.patterns.each do |pattern|
# 	proxy "/patterns/#{pattern[:page_name]}",
# 	"patterns/template.html",
# 	:locals => {
# 		:examples => pattern[:examples],
# 		:page_name => pattern[:page_name],
# 		:page_title => pattern[:page_title],
# 		:page_classes => patterns_prefix + pattern[:page_name],
# 		:section_class => patterns_section_class,
# 		:page_description => pattern[:page_description]
# 	},
# 	:ignore => true
# end

activate :directory_indexes
activate :automatic_alt_tags

activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
  config.cascade  = false
end

# Contentful configuration
SPACE_ID = 'kw7pc879iryd'
MASTER_ACCESS_TOKEN  = ENV['CONTENTFUL_MASTER_TOKEN']
PREVIEW_ACCESS_TOKEN = ENV['CONTENTFUL_PREVIEW_TOKEN']

contentful_access_token = if env_name == 'production'
  MASTER_ACCESS_TOKEN
else
  PREVIEW_ACCESS_TOKEN
end

if !contentful_access_token
  raise "Missing the #{env_name} contentful access token environment variable."
end

use_contentful_preview_mode = env_name != 'production' # show draft articles only for development/staging

puts "Preview mode?: #{use_contentful_preview_mode}"

class PostMapper < ContentfulMiddleman::Mapper::Base
  def map(context, entry)
    super
    context.last_updated = entry.sys[:updatedAt].strftime("%B %-d, %Y")
  end
end

# Load help pages from contentful
# find them in data.help_pages.page[page_id]
activate :contentful do |f|
  f.space = { help_pages: SPACE_ID }
  f.use_preview_api = use_contentful_preview_mode
  f.access_token = contentful_access_token
  f.cda_query     = { content_type: 'post', locale: '*' }
  f.content_types = { page: { mapper: PostMapper, id: 'post' } }
  f.all_entries = true
end

# Load help categories from contentful
# find them in data.help_categories.category[category_id]
activate :contentful do |f|
  f.space = { help_categories: SPACE_ID }
  f.use_preview_api = use_contentful_preview_mode
  f.access_token = contentful_access_token
  f.cda_query     = { content_type: 'category', locale: '*' }
  f.content_types = { category: 'category' }
  f.all_entries = true
end

# dynamic help pages
if data.respond_to?(:help_pages)
  data&.help_pages&.page.each do |page|
    data.locale_urls.each do |locale|
      if page.last["content"] && !page.last["content"].blank? &&
         page.last["meta_description"] && !page.last["meta_description"].blank? &&
         (page.last["content"][alternative_locale(locale)] || (!page.last["content"][alternative_locale(locale)] && page.last["content"]["en"]))
        proxy "#{locale.path}/#{ConfigHelper.help_page_url_slug(page.last)}.html", "content_template.html", locals: {page: page}, ignore: true
      end
    end
  end
end

# dynamic pages see data/locale_pages.yml
data.locale_pages.each do |locale|
  config[:country_id] = locale[:id]
  config[:locale_obj] = locale
  locale.pages.each do |page|
    if page[:page] == 'index'
      if locale.id == 'usa'
        proxy "/index.html", "page-index.html", :locals => { locale_obj: locale }, ignore: true
      else
        proxy "/#{locale.id}/index.html", "/page-index.html", :locals => { locale_obj: locale }, ignore: true
      end
    else
      if locale.id == 'usa'
        proxy "/#{page[:page]}/index.html", "page-#{page[:page]}.html", :locals => { locale_obj: locale }, ignore: true
      else
        proxy "/#{locale.id}/#{page[:page]}/index.html", "/page-#{page[:page]}.html", :locals => { locale_obj: locale }, ignore: true
      end
    end
  end
end

activate :sprockets

# Build-specific configuration
configure :build do
  activate :remover, :paths => %w(page-index patterns)
  activate :gzip do |gzip|
    gzip.exts = %w(.js .css .html .htm .svg .txt .ico)
  end

  # change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
  set :js_compressor, Uglifier.new()

  # Enable cache buster
  activate :asset_hash, :ignore => [/touch-icon/, /opengraph/]

  activate :minify_html do |html|
    html.remove_http_protocol    = false
    html.remove_input_attributes = false
    html.remove_quotes           = true
    html.remove_intertag_spaces  = true
  end
end

after_build do
  # now that the build is done, create any 301 redirects needed
  puts "Environment: #{env_name} and Travis-PR: #{ENV['TRAVIS_PULL_REQUEST']}"
  if ['staging', 'production'].include?(env_name) && ENV['TRAVIS_PULL_REQUEST'] == "false"
    puts "after_build: updating 301 redirects"
    S3RedirectsHelper::make_s3_redirects
  else
    puts "after_build: skipping 301 redirect update"
  end
end

if ApplicationConfig.const_defined?(:S3) && ['staging', 'production'].include?(env_name)
  activate :s3_sync do |s3_sync|
    s3_sync.bucket                     = ApplicationConfig::S3::BUCKET
    s3_sync.region                     = 'us-east-1' # AWS region for your bucket.
    s3_sync.aws_access_key_id          = ApplicationConfig::S3::ACCESS_ID
    s3_sync.aws_secret_access_key      = ApplicationConfig::S3::SECRET_KEY
    s3_sync.delete                     = false
    s3_sync.after_build                = false # We do not chain after the build step by default.
    s3_sync.prefer_gzip                = true
    s3_sync.path_style                 = true
    s3_sync.reduced_redundancy_storage = false
    s3_sync.acl                        = 'public-read'
    s3_sync.encryption                 = false
  end

  default_caching_policy                    max_age: (60 * 60 * 24), public: true
  caching_policy 'text/html',               max_age: (60 * 15), public: true
  caching_policy 'application/xml',         max_age: (60 * 15), public: true
  caching_policy 'image/svg',               max_age: (60 * 15), public: true
  caching_policy 'application/json',        max_age: (60 * 15), public: true
  caching_policy 'application/javascript',  max_age: (60 * 15), public: true
end
