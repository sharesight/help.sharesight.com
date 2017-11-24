require "test_helper"
require File.expand_path(File.dirname(__FILE__) + "/../../helpers/config_helper")

class RegionHelperTest < Minitest::Test

    context "page_meta_by_region" do
      should "return page title for usa" do
        # assert "Sharesight Help", RegionHelper.page_meta_by_region(data.locale_pages, 'usa', 'index.html').first[:page_title]
      end
    end

    context "locale_from_url" do

      # should "return / when user is on home page and region is GLOBAL" do
      #   url = ""
      #   assert "/", RegionHelper.locale_from_url(url)
      # end
      #
      # should "return / when user is viewing a page and region is GLOBAL" do
      #   url = "/unquoted-instruments"
      #   assert "/", RegionHelper.locale_from_url(url)
      # end
      #
      # should "return region when user is on home page" do
      #   url = "/nz/"
      #   assert "nz", RegionHelper.locale_from_url(url)
      # end
      #
      # should "return region when user is viewing page" do
      #   url = "/nz/import-from-csv-file"
      #   assert "nz", RegionHelper.locale_from_url(url)
      # end

  end
end
