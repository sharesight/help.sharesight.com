require "test_helper"
require File.expand_path(File.dirname(__FILE__) + "/../../helpers/config_helper")

class BreadcrumbHelperTest < Minitest::Test

    context "parent_slug" do
      should "return global url when user region is GLOBAL" do
      end

      should "return region url when user region is not global" do
      end
    end

    context "parent" do
      should "return page title" do
      end
    end

    context "child" do
      should "return page title" do
      end
    end

    context "find_page_id" do
      should "return id for a given page" do
      end
    end

    context "parent_id" do
      should "return parent id for a given page" do
      end
    end

end
