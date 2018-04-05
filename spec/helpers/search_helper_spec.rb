require 'spec_helper'

describe 'Search Helper', :type => :helper do
  context "stop words" do
    it "should filter out common words" do
      content = "portfolio FIF the and merge dividend a"
      expected_result = "portfolio FIF merge dividend"
      expect(expected_result).to eq(SearchHelper.condense_content(content))
    end
  end
end
