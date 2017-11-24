require "test_helper"

require File.expand_path(File.dirname(__FILE__) + "/../../helpers/category_helper")
require File.expand_path(File.dirname(__FILE__) + "/../../helpers/config_helper")

class CategoryHelperTest < Minitest::Test
  context "menu" do
    should "build proper menu" do
      @app = application_instance
      menu = CategoryHelper.navigation_menu_structure(@app.data)
      assert menu
      refute menu.empty?
      first_item = menu.first
      assert_match /Getting started/, first_item[menu.first.keys.first][:category_name]
    end
  end
end
