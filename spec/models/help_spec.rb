require 'spec_helper'

describe 'help', :type => :model do
  before :all do
    @data = Capybara.app.data.help
  end

  it "should have a base directory" do
    page_data_dir = dir_list("data/help")
    expect(page_data_dir - [".", ".."]).not_to be_empty
  end

  it "should have data in middleman" do
    expect(@data).not_to be_empty
  end
end
