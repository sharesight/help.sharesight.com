require 'cgi'
require 'spec_helper'

describe 'Help Pages', :type => :feature do
  it "should load and have expected base metas" do
    locales.each do |locale|
      get_pages(locale, true).each do |_page|
        visit _page[:path]

        expect(page).to respond_successfully

        expect(page).to have_base_metas()
        expect(page).to have_social_metas()
        expect(page).to have_titles(_page[:page_title])
        expect(page).to have_descriptions(_page[:meta_description])
      end
    end
  end

  it "should have expected urls" do
    locales.each do |locale|
      get_pages(locale, true).each do |_page|
        visit _page[:path]

        expect(page).to have_meta('og:url', base_url(_page[:path]), name_key: 'property')

        expect(page).to have_head('link', args: { rel: 'canonical', href: absolute_url(_page[:path]) }, debug: :href)

        Capybara.app.page_content_locales(_page).each do |alternate_locale|
          if alternate_locale[:id] == default_locale_id
            expect(page).to have_head('link', args: { rel: 'alternate', href: localize_url(_page[:path], locale_id: default_locale_id), hreflang: 'x-default' }, debug: :href)
          end
          expect(page).to have_head('link', args: { rel: 'alternate', href: localize_url(_page[:path], locale_id: alternate_locale[:id]), hreflang: alternate_locale[:lang].downcase }, debug: :href)
        end
      end
    end
  end

  it "should have the expected elements" do
    locales.each do |locale|
      get_pages(locale, true).each do |_page|
        visit _page[:path]

        expect(page).to have_css('.breadcrumbs li', text: "Help")
        expect(page).to have_css('.breadcrumbs li', text: _page[:parent_page][:title].strip) if _page[:parent_page]
        expect(page).to have_css('.breadcrumbs li.breadcrumb-extra', text: _page[:title].strip)

        expect(page).to have_css('h1', text: _page[:title].strip)
        expect(page).to have_css('p.date_modified', text: /Last modified on/)
      end
    end
  end

  it "should have all help topics in navigation" do
    locales.each do |locale|
      get_pages(locale, true).each do |_page|
        visit _page[:path]

        get_categories(locale).each do |category|
          expect(page).to have_css("h4[data-toggle]", text: category[:name].strip), "Could not find #{category[:name]} in navigation on #{_page[:path]}"
        end

        pages_in_this_locale = get_pages(locale)

        pages_in_this_locale.each do |_page|
          # if the page has multiple parents, it doesn't show; navigation only goes one layer deep
          has_multiple_parents = true if _page[:parent_page] && _page[:parent_page][:parent_page]
          unless has_multiple_parents
            page_url = Capybara.app.page_url(_page, locale_id: locale[:id])
            expect(page).to have_css("a[href='#{page_url}']", text: _page[:title].strip, visible: false) # visible or not
          end
        end
      end
    end
  end

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

  it "should have a footer" do
    locales.each do |locale|
      visit locale.path

      expect(page).to have_css('p.footer__intro', text: 'Simply the best portfolio management tool for DIY investors.')
      expect(page).to have_css('.footer__copyright', text: 'All rights reserved.')
    end
  end
end
