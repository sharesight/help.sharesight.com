require 'aws/s3'
require 'uri'

#
# execute: S3RedirectsHelper::make_s3_redirects
# dry run execute: S3RedirectsHelper::make_s3_redirects(true)
#
module S3RedirectsHelper

  BASE_DIR_STUFF_TO_IGNORE = [
    "index.html", "js", "fonts", "img", "patterns", "css"
  ]

  def self.make_s3_redirects(dry_run = false)
    return unless ["staging", "production"].include?(ENV['APP_ENV']) && ENV['TRAVIS_PULL_REQUEST'] == 'false'
    puts "Env is #{ENV['APP_ENV']}, dry run is #{dry_run}"

    bucket_name = ::ApplicationConfig::S3::BUCKET

    make_connection

    base_dir_objects = Dir.entries("build") - BASE_DIR_STUFF_TO_IGNORE
    directory_queue = Queue.new
    base_dir_objects.each { |o| directory_queue << o if include_file?(o) }

    while !directory_queue.empty? do
      current_dir = directory_queue.pop

      Dir.entries(File.join("build", current_dir)).each do |object|
        full_name = File.join(current_dir, object)

        next unless include_file?(object)

        # if object is a directory, store it to read later
        directory_queue << full_name if File.directory?(full_name)

        if !object.match(%r{index\.html$})
          # add a "no trailing slash" redirect for the directory, using new S3
          # object of 'directory/index.html'
          create_redirect("/#{full_name}", "/#{full_name}/", bucket_name, dry_run)
        end
      end
      create_redirect("/#{current_dir}", "/#{current_dir}/", bucket_name, dry_run)
    end
  end

  private

  def self.include_file?(filename)
    return if filename.match /\.(txt|gz|json|xml)$/ # ignore these zipped pages
    return if filename.match /^\.$/ # ignore .
    return if filename.match /^\.\.$/ # ignore ..
    return if filename.match /^favicon.ico$/ # ignore ..
    true
  end

  def self.create_redirect(source_path, target_path, bucket_name, dry_run = false)
    create_redirect_file source_path, target_path, bucket_name, false, dry_run
  end

  # deletes the old redirect, if it existed
  def self.create_redirect!(source_path, target_path, bucket_name, dry_run = false)
    create_redirect_file source_path, target_path, bucket_name, true, dry_run
  end

  def self.make_connection
    AWS::S3::Base.establish_connection!(
      access_key_id: ::ApplicationConfig::S3::ACCESS_ID,
      secret_access_key: ::ApplicationConfig::S3::SECRET_KEY
    )
  end


  def self.create_redirect_file(source_path, target_path, bucket_name, override_existing = false, dry_run = false)
    if AWS::S3::S3Object.exists?(source_path, bucket_name)
      print "#{source_path} already exists "
      if override_existing
        puts "deleting old redirect..."
        AWS::S3::S3Object.delete(source_path, bucket_name) unless dry_run
      else
        puts "ignoring..."
        return
      end
    end
    puts "Creating a 301 redirect for object #{source_path} to #{target_path}"
    AWS::S3::S3Object.store(source_path, nil, bucket_name, 'x-amz-website-redirect-location': URI.encode(target_path), 'Content-Type': 'text/html') unless dry_run
  end
end
