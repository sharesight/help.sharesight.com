require 'spec_helper'

describe 'Sitemap', :type => :feature do
  before :all do
    @path = 'sitemap.xml'
    @validated = []
  end

  it "should have a sitemap index" do
    visit '/sitemapindex.xml'
    expect(page).to have_xpath('//sitemapindex')

    # we check these numbers to be exact matches below as well
    expect(all(:xpath, '//sitemapindex/sitemap').length).to eq(locales.length)
    expect(all(:xpath, '//sitemapindex/sitemap/loc').length).to eq(locales.length)
  end

  it "should look like a sitemap" do
    locales.each do |locale|
      visit localize_path('sitemap.xml', locale_id: locale[:id])
      expect(page).to have_xpath('//urlset')

      # we check these numbers to be exact matches below as well
      expect(all(:xpath, '//urlset/url').length).to be > 0
      expect(all(:xpath, '//urlset/url/loc').length).to be > 0
      expect(all(:xpath, '//urlset/url/priority').length).to be > 0
      expect(all(:xpath, '//urlset/url/link').length).to be > 0
    end
  end

  it "should have the right length of links" do
    locales.each do |locale|
      visit localize_path('sitemap.xml', locale_id: locale[:id])

      expectation = 0
      expectation += locale[:pages].reject{ |_page| _page.show_in_sitemap == false }.length

      # get all pages with content in this locale
      expectation += get_pages(locale, true).length

      expect(all(:xpath, '//urlset/url').length).to eq(expectation), "Got #{all(:xpath, '//urlset/url').length} urls, expected #{expectation} in #{locale[:id]}"
      expect(all(:xpath, '//urlset/url/loc').length).to eq(expectation), "Got #{all(:xpath, '//urlset/url/loc').length} url/locs, expected #{expectation} in #{locale[:id]}"
    end
  end

  it "should have all the help pages" do
    locales.each do |locale|
      visit localize_path('sitemap.xml', locale_id: locale[:id])

      get_pages(locale, true).each do |_page|
        url = Capybara.app.page_url(_page, locale_id: locale[:id])

        xpath = generate_xpath('//urlset/url/loc', text: url)
        expect(page).to have_xpath(xpath), "#{_page.name} is missing in #{locale[:id]} sitemap (expected #{url})."

        Capybara.app.page_content_locales(_page).each do |sublocale|
          url = Capybara.app.page_url(_page, locale_id: sublocale.id)
          xpath = generate_xpath('//urlset/url/link', args: { href: url })
          expect(page).to have_xpath(xpath), "#{_page.name} is missing in #{locale[:id]} sitemap (expected #{url})."
        end
      end
    end
  end

  it "should have all the pages" do
    locales.each do |locale|
      visit localize_path('sitemap.xml', locale_id: locale[:id])

      locale.pages.each do |page_data|
        url = localize_url("/#{page_data.page}", locale_id: locale.id)
        xpath = generate_xpath('//urlset/url/loc', text: url)

        unless page_data.show_in_sitemap == false
          expect(page).to have_xpath(xpath)
        end
      end
    end
  end

  it "should have all valid links and locs" do
    locales.each do |locale|
      visit localize_path('sitemap.xml', locale_id: locale[:id])

      links = []
      links << all('//urlset/url/loc').map{ |xpath| xpath.text() }
      links << all('//urlset/url/link').map{ |xpath| xpath['href'] }
      links = links.flatten.uniq

      links.each do |link|
        # don't re-visit every url
        if !@validated.include?(link)
          visit link
          @validated << link
          expect(page).to respond_successfully
        end
      end
    end
  end
end
