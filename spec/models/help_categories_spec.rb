require 'spec_helper'

describe 'Help Categories', :type => :model do
  before :all do
    @data = Capybara.app.data.help.categories
    @collection = get_categories()

    @fields = [
      :id, :_meta,
      :name, :description, :order
    ]
  end

  it "should have a directory" do
    page_data_dir = dir_list("data/help/categories")
    expect(page_data_dir - [".", ".."]).not_to be_empty
  end

  it "should have a list of tuples as data array" do
    @data.each do |tuple|
      expect(tuple).to be_kind_of(Array)
      expect(tuple[0]).to be_kind_of(String)
      expect(tuple[1]).not_to be_falsey
    end
  end

  it "should have data in middleman" do
    expect(@data).not_to be_empty
    expect(@collection).not_to be_empty
  end

  it "should have unique titles" do
    expect(@collection.map{ |model| model[:name] }.uniq.count).to eq(@collection.count)
  end

  it "should have unique urls" do
    expect(@collection.map{ |model| Capybara.app.category_url(model) }.uniq.count).to eq(@collection.count)
  end

  it "should have the required schema fields" do
    schema = @collection.map{ |x| x.to_h.keys }.flatten.uniq # list of all keys in all models
    schema = schema.map{ |x| x.to_sym }

    expect(schema).to include(*@fields) # this converts array to args
  end

  it "should have valid data in production" do
    # skip "Skipping for non-production builds." if Capybara.app.config[:env_name] != 'production'

    @collection.each do |model|
      is_valid = model && model[:id] && model[:name] rescue false

      expect(is_valid).to be_truthy, "Help Category #{model[:id]} is invalid."
    end
  end
  end
