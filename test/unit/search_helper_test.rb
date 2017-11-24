require "test_helper"

require File.expand_path(File.dirname(__FILE__) + "/../../helpers/search_helper")

class SearchHelperTest < Minitest::Test
  context "stop words" do
    should "filter out common words" do
      content = "portfolio FIF the and merge dividend a"
      expected_result = "portfolio FIF merge dividend"
      assert_equal expected_result, SearchHelper.condense_content(content)
    end
  end
end
