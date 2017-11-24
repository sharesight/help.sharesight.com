require "test_helper"
require 'find'

class SanityCheckTest < Minitest::Test

  context "build sanity" do
    should "have data from Contentful" do
      page_data_dir = list("data/help_pages/page/")
      refute (page_data_dir - [".", ".."]).empty?
      category_data_dir = list("data/help_categories/category/")
      refute (category_data_dir - [".", ".."]).empty?
    end

    should "have built a site" do
      build_dir = list("build")
      assert build_dir.include? "index.html"
      assert build_dir.include? "contents.json"
      assert build_dir.include? "robots.txt"
      assert build_dir.include? "sitemap.xml"
      assert build_dir.include? "au"
      assert build_dir.include? "ca"
      assert build_dir.include? "nz"
      assert build_dir.include? "uk"

      # check au stuff
      au_dir = list("build/au")
      assert au_dir.include? "index.html"
      assert au_dir.include? "capital_gains"
      refute au_dir.include? "fif_income_summary_page"

      # check ca stuff
      ca_dir = list("build/ca")
      assert ca_dir.include? "index.html"
      refute ca_dir.include? "fif_income_summary_page"

      # check nz stuff
      nz_dir = list("build/nz")
      assert nz_dir.include? "index.html"
      assert nz_dir.include? "fif_income_summary_page"

      # check uk stuff
      uk_dir = list("build/uk")
      assert uk_dir.include? "index.html"
      refute uk_dir.include? "fif_income_summary_page"
    end

    should "include zero git conflict markers in source" do
      ignore_files = [ "favicon.ico", "woff", "jpg", "png" ] # ignore non-texty files
      Find.find(File.expand_path(File.dirname(__FILE__) + "/../../source")) do |path|
        if ignore_files.none? { |ignore| path.match(ignore)  } && FileTest.file?(path)
          begin
            assert File.foreach(path).grep(/(\<{7}|\>{7})/).empty?
          rescue ArgumentError => e
            if e.message.match("invalid byte sequence in UTF-8")
              puts "ignoring binary file #{path}"
            end
          end
        end
      end
    end

    context "video embedding" do
      should "include embedly in general pages" do
        assert_match /embedly.*platform/, read("build/au/index.html")
      end

      should "include embedly in article pages" do
        assert_match /embedly.*platform/, read("build/au/getting-started-with-sharesight/index.html")
        assert_match /embedly.*platform/, read("build/au/capital_gains/index.html")
      end
    end
  end

end
