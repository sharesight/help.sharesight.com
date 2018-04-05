require 'spec_helper'

describe 'Page Helper', :type => :helper do
  before :all do
    @app = Capybara.app
  end

  before :each do
    visit '/'
  end

  context "current_path_array" do
    it "should be an array" do
      expect(@app.current_path_array).to be_kind_of(::Array)

      visit '/nz'
      expect(@app.current_path_array).to be_kind_of(::Array)
    end

    it "should include what we expect" do
      expect(@app.current_path_array).to include('index.html')

      visit '/nz/something/foo-bar'
      expect(@app.current_path_array).to eq(['index.html']) # invalid page, falls back to previous path
    end
  end

  context "full_page_path_name" do
    it "should be a string" do
      expect(@app.full_page_path_name).to be_kind_of(::String)
    end

    it "should match expectations for valid pages" do
      [
        # [input, expectation]
        ['/', 'index'],
        ['/nz', 'index'],
      ].each do |array|
        visit array[0]
        expect(@app.full_page_path_name).to eq(array[1])
      end
    end
  end

  context "page_path_name" do
    it "should be a string" do
      expect(@app.page_path_name).to be_kind_of(::String)

      visit '/nz'
      expect(@app.page_path_name).to be_kind_of(::String)
    end

    it "should match what we expect" do
      expect(@app.page_path_name).to eq('index')

      visit '/nz'
      expect(@app.page_path_name).to eq('index')
    end
  end

  context "current_locale_page" do
    # This is a 1:1 proxy of locale_page
    it "should be the page we expect" do
      expect(@app.current_locale_page[:page]).to eq('index')

      visit '/404'
      expect(@app.current_locale_page[:page]).to eq('404')
    end
  end

  context "valid_page_from_path" do
    # This is a 1:1 proxy of locale_page
    it "should be the page we expect" do
      [
        # [input, expectation]
        ['/', 'index'],
      ].each do |array|
        visit array[0]
        expect(@app.valid_page_from_path).to eq(array[1])
      end
    end
  end

  context "base_locale_page" do
    it "should be the page of the global locale" do
      expect(@app.base_locale_page(page: 'index')[:page_title]).to eq("Sharesight Help")
    end
  end

  context "locale_page" do
    it "should respond with the right page id" do
      expect(@app.locale_page(page: 'index')[:page]).to eq('index')

      expect(@app.locale_page(page: 'fake-page')).to eq(nil)
    end
  end

  context "page_counts" do
    it "should be a hash" do
      expect(@app.page_counts).to be_kind_of(::Hash)
    end

    it "should match expected counts" do
      expect(@app.page_counts['index']).to eq(5)
      expect(@app.page_counts['404']).to eq(5)

      expect(@app.page_counts['fake-page']).to eq(nil)
    end
  end

  context "page_alternative_locales" do
    it "should be an array" do
      expect(@app.page_alternative_locales('index')).to be_kind_of(::Array)
    end

    it "should match expected counts" do
      expect(@app.page_alternative_locales('index').length).to eq(5)
      expect(@app.page_alternative_locales('404').length).to eq(5)

      expect(@app.page_alternative_locales('fake-page')).to eq([])
    end
  end

  context "is_valid_page?" do
    it "should match expectations" do
      expect(@app.is_valid_page?('index')).to be true
      expect(@app.is_valid_page?('404')).to be true

      expect(@app.is_valid_page?(nil)).to be false
      expect(@app.is_valid_page?('fake-page')).to be false
    end
  end

  context "is_valid_locale_id_for_page?" do
    it "should match expectations" do
      locales.each do |locale|
        expect(@app.is_valid_locale_id_for_page?('index', locale[:id])).to be true
      end

      expect(@app.is_valid_locale_id_for_page?('index', 'gb')).to be false
    end
  end

  context "get_page_base_locale" do
    it "should match expectations" do
      expect(@app.get_page_base_locale('index')[:id]).to eq(default_locale_id)

      # Bad pages always get default
      expect(@app.get_page_base_locale(nil)[:id]).to eq(default_locale_id)
      expect(@app.get_page_base_locale('foo')[:id]).to eq(default_locale_id)
    end
  end

  context "is_unlocalized_page" do
    it "should return false for index" do
      expect(@app.is_unlocalized_page?('index')).to be false
    end

    it "should return false for an unknown page" do
      expect(@app.is_unlocalized_page?('some-fake-page-please-dont-make-this')).to be false
      expect(@app.is_unlocalized_page?(nil)).to be false
    end
  end

  context "generate_social_title" do
    it "should strip the localization of the title" do
      [
        # [input, expectation]
        ['Foo Bar | Sharesight Canada Help', 'Foo Bar | Sharesight Help'],
        ['Foo Bar | Sharesight Help', 'Foo Bar | Sharesight Help'],
        ['Foo Bar | Sharesight Australia Help', 'Foo Bar | Sharesight Help'],
        ['Foo Bar | Sharesight Unknown Help', 'Foo Bar | Sharesight Unknown Help'],
        ['Foo Bar | Canada', 'Foo Bar | Canada'],
        ['Foo Bar + Sharesight Australia', 'Foo Bar + Sharesight Australia'],
        ['Foo Bar - Sharesight Australia', 'Foo Bar - Sharesight Australia'],
        ['Foo Bar |Sharesight Australia', 'Foo Bar |Sharesight Australia'],
        [' | Sharesight UK Help', '| Sharesight Help'],
        ['Sharesight UK', 'Sharesight UK'],

        ['Foo Bar | Sharesight Canada Help Partners', 'Foo Bar | Sharesight Help Partners'],
        ['Foo Bar | Sharesight Canada Help FooBar', 'Foo Bar | Sharesight Help FooBar'],
        ['Foo Bar | Sharesight Canadian Help FooBar', 'Foo Bar | Sharesight Canadian Help FooBar']
      ].each do |array|
        expect(Capybara.app.generate_social_title(array[0])).to eq(array[1])
      end
    end
  end
end
