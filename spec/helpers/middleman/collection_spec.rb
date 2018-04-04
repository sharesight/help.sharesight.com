require 'spec_helper'

describe 'Collection Middleman Helper', :type => :helper do
  before :all do
    @app = Capybara.app
    @url = Capybara.app.config[:base_url]
  end

  context "page_url and page_path" do
    # This is a proxy to other tested helpers.
    it "should return a string" do
      get_pages().each do |page|
        expect(@app.page_url(page)).to be_kind_of(::String)
        expect(@app.page_path(page)).to be_kind_of(::String)
      end
    end
  end

  context "category_url and category_path" do
    # This is a proxy to other tested helpers.
    it "should return a string" do
      get_categories().each do |category|
        expect(@app.category_url(category)).to be_kind_of(::String)
        expect(@app.category_path(category)).to be_kind_of(::String)
      end
    end
  end

  context "pages_collection" do
    it "should be an array of hashes" do
      data = @app.pages_collection()
      expect(data).to be_kind_of(Array)
      data.each do |a|
        expect(a).to include(:id)
        expect(a).to include(:content)
      end
    end

    it "should include child pages when associations are requested" do
      data = @app.pages_collection(with_associations: true)
      expect(data).to be_kind_of(Array)
      data.each do |a|
        expect(a).to include(:child_pages)
        expect(a[:child_pages]).to be_kind_of(Array)
      end
    end
  end

  context "categories_collection" do
    it "should be an array of hashes" do
      data = @app.categories_collection(with_associations: true)
      expect(data).to be_kind_of(Array)
      data.each do |a|
        expect(a).to include(:id)
        expect(a).to include(:title)
      end
    end

    it "should include pages when associations are requested" do
      data = @app.categories_collection(with_associations: true)
      expect(data).to be_kind_of(Array)
      data.each do |a|
        expect(a).to include(:pages)
        expect(a[:pages]).to be_kind_of(Array)
      end
    end
  end
end
