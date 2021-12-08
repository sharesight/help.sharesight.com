require 'cgi'
require 'spec_helper'

describe 'Help Pages', :type => :feature do

  Capybara.app.data.locales.each do |locale|
    it "should load and have expected base metas for locale #{locale['id']}" do
      get_pages(locale).each do |_page|
        visit _page[:path]

        expect(page).to respond_successfully
        expect_basic_metas(page, _page)
        expect_urls(page, _page)
        expect_elements(page, _page)
        expect_help_topics_in_navigation(page, _page, locale)
      end
    end

    it "should load for locale #{locale['id']}" do
      visit locale.path

      expect(page).to have_css('input#search-field')
      expect_search_field(page)
      expect_login_and_go_to_button(page)
      expect_footer(page)
    end
  end

  private

  def expect_search_field(page)
    expect(page).to have_css('input#search-field')
  end

  def expect_login_and_go_to_button(page)
    expect(page).to have_css('a', text: 'Login')
    expect(page).to have_css('a', text: 'Go to sharesight.com')
  end

  def expect_footer(page)
    expect(page).to have_css('p.footer__intro', text: 'Simply the best portfolio management tool for DIY investors.')
    expect(page).to have_css('.footer__copyright', text: 'All rights reserved.')
  end

  def expect_basic_metas(page, page_data)
    expect(page).to have_base_metas()
    expect(page).to have_social_metas()
    expect(page).to have_titles(page_data[:page_title])
    expect(page).to have_descriptions(page_data[:meta_description])
  end

  def expect_urls(page, page_data)
    expect(page).to have_meta('og:url', base_url(page_data[:path]), name_key: 'property')

    expect(page).to have_head('link', args: { rel: 'canonical', href: absolute_url(page_data[:path]) }, debug: :href)

    locales.each do |alternate_locale|
      if alternate_locale[:id] == default_locale_id
        expect(page).to have_head('link', args: { rel: 'alternate', href: localize_url(page_data[:path], locale_id: default_locale_id), hreflang: 'x-default' }, debug: :href)
      end
      expect(page).to have_head('link', args: { rel: 'alternate', href: localize_url(page_data[:path], locale_id: alternate_locale[:id]), hreflang: alternate_locale[:lang].downcase }, debug: :href)
    end
  end

  def expect_elements(page, page_data)
    expect(page).to have_css('.breadcrumbs li', text: "Help")
    expect(page).to have_css('.breadcrumbs li', text: page_data[:parent_page][:title].strip) if page_data[:parent_page]
    expect(page).to have_css('.breadcrumbs li.breadcrumb-extra', text: page_data[:title].strip)
    expect(page).to have_css('h1', text: page_data[:title].strip)
    expect(page).to have_css('p.date_modified', text: /Last modified on/)
  end

  def expect_help_topics_in_navigation(page, page_data, locale)
    get_categories(locale).each do |category|
      expect(page).to have_css("h4[data-toggle]", text: category[:name].strip), "Could not find #{category[:name]} in navigation on #{page_data[:path]}"
    end

    pages_in_this_locale = get_pages(locale)

    pages_in_this_locale.select do |_page| 
      # if the page has multiple parents, it doesn't show; navigation only goes one layer deep
      return false if _page[:parent_page] && _page[:parent_page][:parent_page]

      # We hide this category…
      return false if _page[:category][:name] === 'Miscellaneous'

      return true
    end.each do |_page|
      page_url = Capybara.app.page_url(_page, locale_id: locale[:id])
      expect(page).to have_css("a[href='#{page_url}']", text: _page[:title].strip, visible: false) # visible or not
    end
  end

end
