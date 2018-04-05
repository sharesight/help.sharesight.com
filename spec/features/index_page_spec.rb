require 'spec_helper'

describe 'Index Page', :type => :feature do
  it "should have a search field" do
    locales.each do |locale|
      visit locale.path

      expect(page).to have_css('input#search-field')
    end
  end

  it "should have login and go to sharesight buttons" do
    locales.each do |locale|
      visit locale.path

      expect(page).to have_css('a', text: 'Login')
      expect(page).to have_css('a', text: 'Go to sharesight.com')
    end
  end

  it "should have all help topics" do
    locales.each do |locale|
      visit locale.path
      expect(page).to have_text("Browse Sharesight Help Topics")

      get_categories(locale).each do |category|
        category_url = Capybara.app.category_url(category, locale_id: locale[:id])
        expect(page).to have_css("a[href='#{category_url}']", text: category[:name]) # should also have a description in there, but doesn't quite work with have_css
      end
    end
  end

  it "should have a community and videos section" do
    locales.each do |locale|
      visit locale.path

      expect(page).to have_css('h2', text: 'Sharesight Community')
      expect(page).to have_css("a[href='#{Capybara.app.config[:community_url]}']", text: 'Visit our Forum')

      expect(page).to have_css('h2', text: 'Videos & Guides')
      expect(page).to have_css("a[href*='youtube.com']", text: 'View all Videos')
    end
  end

  it "should have a footer" do
    locales.each do |locale|
      visit locale.path

      expect(page).to have_css('p.footer__intro', text: 'Simply the best portfolio management tool for DIY investors.')
      expect(page).to have_css('.footer__copyright', text: 'All rights reserved.')
    end
  end
end
