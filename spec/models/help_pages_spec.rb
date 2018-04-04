require 'spec_helper'

describe 'Help Pages', :type => :model do
  before :all do
    @data = Capybara.app.data.help.pages
    @collection = get_pages()

    @fields = [
      :id, :_meta,
      :title, :url_slug, :meta_description, :category, :parent_page, :featured_image, :order
    ]

    @localized = [
      :content, :keywords
    ]
  end

  it "should have a directory" do
    page_data_dir = dir_list("data/help/pages")
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
    expect(@collection.map{ |model| model[:title] }.uniq.count).to eq(@collection.count)
  end

  it "should have unique urls" do
    expect(@collection.map{ |model| Capybara.app.page_url(model) }.uniq.count).to eq(@collection.count)
  end

  it "should have the required schema fields" do
    schema = @collection.map{ |x| x.to_h.keys }.flatten.uniq # list of all keys in all models
    schema = schema.map{ |x| x.to_sym }

    expect(schema).to include(*@fields) # this converts array to args
  end

  it "should have localization on the data in Production" do
    skip "Skipping for non-production builds." if Capybara.app.config[:env_name] != 'production'

    # This is an array of [key, [sub-keys]]
    # Primarily used for locale validation, eg. ["name", ["en", "en-NZ"]]
    schema = @data.map{ |i, x| x.select{ |k, v| v.kind_of?(::Hash) }.map{ |k, v| [k, v.to_h.keys] } }.flatten(1).uniq

    @localized.each do |field|
      schema.select{ |key, locales| key.to_s == field.to_s }.each do |key, locales|
        expect(locales).to include('en'), "Missing the `en` localization on #{field}, got locales: #{locales}"
      end
    end
  end

  it "should have valid data in production" do
    skip "Skipping for non-production builds." if Capybara.app.config[:env_name] != 'production'

    @collection.each do |model|
      is_valid = model &&
        model[:name] && # model[:url_slug] &&
        model[:content] && model[:content].is_a(String) &&
        model[:category][:id] rescue false

      expect(is_valid).to be_truthy, "Help Page #{model[:id]} is invalid."
    end
  end
  end
