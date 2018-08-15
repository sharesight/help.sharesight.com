require 'spec_helper'

describe 'Build Sanity', :type => :feature do
  it "should have data from Contentful" do
    page_data_dir = dir_list("data/help/pages/")
    expect(page_data_dir - [".", ".."]).not_to be_empty
    expect(Capybara.app.data.help.pages.length).to be > 0

    category_data_dir = dir_list("data/help/categories/")
    expect(category_data_dir - [".", ".."]).not_to be_empty
    expect(Capybara.app.data.help.categories.length).to be > 0
  end

  it "should have built a site" do
    root_dir = dir_list("build")
    # technical assets directories
    expect(root_dir).to include("js")
    expect(root_dir).to include("img")
    expect(root_dir).to include("css")

    # files only in root directory
    expect(root_dir).to include("favicon.ico")
    expect(root_dir).to include("favicon-16x16.png")
    expect(root_dir).to include("favicon-32x32.png")
    expect(root_dir).to include("robots.txt")

    ['', 'au', 'ca', 'nz', 'uk'].each do |locale_id|
      expect(root_dir).to include(locale_id) if locale_id != ''
      dir = dir_list("build/#{locale_id}")
      expect(dir).to include("index.html")
      expect(dir).to include("contents.json")
      expect(dir).to include("sitemap.xml")
    end
  end

  it "should not include git conflict markers in source" do # checks for <<<<<<< (7 of those)
    ignore_files = [ "favicon.ico", ".woff", ".jpg", ".png", ".mp4", ".webm", ".mov" ] # ignore non-texty files
    Find.find(File.expand_path(File.dirname(__FILE__) + "/../../source")) do |path|
      if ignore_files.none? { |ignore| path.match(ignore)  } && FileTest.file?(path)
        begin
          expect(File.foreach(path).grep(/(\<{7}|\>{7})/)).to be_empty
        rescue ArgumentError => e
          if e.message.match("invalid byte sequence in UTF-8")
            puts "ignoring binary file #{path}"
          end
        end
      end
    end
  end
end
