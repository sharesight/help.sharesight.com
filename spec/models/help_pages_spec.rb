require 'spec_helper'

describe 'Help Pages', :type => :model do
  before :all do
    @data = Capybara.app.data.help.pages
    @collection = get_pages()

    @fields = [
      :id, :_meta,
      :title, :url_slug, :meta_description, :category, :parent_page, :featured_image, :order
    ]

    @localized_fields = [
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

    # Iterate over every page and ensure that any fields listed in @localized_fields that are localized have an `en` locale.
    @data.each do |id, model|
      model.select do |field_name, raw_value|
        # Only grab localized fields that are hashes, eg. should be like: {'en' => 'Something', 'en-AU' => 'Somethoing'}
        @localized_fields.include?(field_name.to_sym) && raw_value.kind_of?(::Hash)
      end.each do |field_name, raw_value|
        locales = raw_value.to_h.keys
        expect(locales).to include('en'), "Missing the 'en' localization for field='#{field_name}' for page id='#{id}'; got locales='#{locales}'."
      end
    end
  end

  it "should have valid data in production" do
    skip "Skipping for non-production builds." if Capybara.app.config[:env_name] != 'production'

    @collection.each do |model|
      expect(model[:title]).to be_truthy, "Help Page #{model[:id]} has a missing title."
      # expect(model[:url_slug]).to be_truthy, "Help Page #{model[:id]} has a missing url slug." # this is auto-generated as well
      expect(model[:content]).to be_truthy, "Help Page #{model[:id]} has missing content."
      expect(model[:content]).to be_kind_of(String), "Help Page #{model[:id]} has invalid content (invalid localization?)."
      expect(model[:category][:id]).to be_truthy, "Help Page #{model[:id]} has a missing category."
    end
  end
  end
