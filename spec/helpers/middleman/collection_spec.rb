require 'spec_helper'

describe 'Collection Middleman Helper', :type => :helper do
  before :all do
    @app = Capybara.app
    @url = Capybara.app.config[:base_url]
  end

  context "page_url and page_path" do
    # This is a proxy to other tested helpers.
    it "should return a string" do
      get_pages().each do |_page|
        expect(@app.page_url(_page)).to be_kind_of(::String)
        expect(@app.page_path(_page)).to be_kind_of(::String)
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
        expect(a).to include(:name)
      end
    end

    it "filters out the Miscellaneous category" do
      # Does exist in the raw data…
      raw_categories = @app.data.help.categories.map{ |tuple| tuple[1] }.map{ |c| c[:name][:en] }
      expect(raw_categories).to include('Miscellaneous')

      # Does not exist in the categories_collection
      categories = @app.categories_collection().map{ |c| c[:name] }
      expect(categories).not_to include('Miscellaneous')

      expect(raw_categories.length).to be > categories.length
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

  # NOTE: This is more of an integration test of this helper.
  context "page_content_locales" do
    before :all do
      @pages = @app.pages_collection()
    end

    it "should give an array of locales (should be all locale)" do
      [
        # [index, locales]
        # every id should actually give all locales, else it will fail in another place...
        # page_content_locales should == app.data.locales
        ['post_185', ["global", "au", "ca", "nz", "uk"]],
        ['5ox0N62c1iiuAaucsMO2UI', ["global", "au", "ca", "nz", "uk"]],
      ].each do |id, expectation|
        this_page = @pages.find{|page| page[:id].to_s == id.to_s}
        page_locales = Capybara.app.page_content_locales(this_page)
        locale_ids = page_locales.map{|l| l[:id]}

        expect(page_locales).to be_kind_of(Array)
        expect(this_page && this_page[:id]).to eq(id), "Page not found for #{id} – has this page been deleted or is invalid?"
        expect(locale_ids).to eq(expectation), "Locales did not match expectation for id: #{this_page[:id]}, got #{locale_ids}, expected #{expectation}"
      end
    end

    it "should return an array with nil input" do
      page_locales = Capybara.app.page_content_locales(nil)
      expect(page_locales).to be_kind_of(Array)
      expect(page_locales).to eq([])
    end
  end
end
