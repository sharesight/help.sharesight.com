require 'spec_helper'

describe 'Footer', type: :feature do
  it 'should have all expected links' do
    visit '/'
    links = page.all(:css, 'a.footer__link')

    expected_links = [
      # text, href

      # Sharesight:
      ["www.sharesight.com", Capybara.app.config[:marketing_url]],
      ["About Us", base_url("/about-sharesight/", base_url: Capybara.app.config[:marketing_url])],
      ["Executive Team", base_url("/team/", base_url: Capybara.app.config[:marketing_url])],
      ["FAQ", base_url("/faq/", base_url: Capybara.app.config[:marketing_url])],
      ["Pricing", base_url("/pricing/", base_url: Capybara.app.config[:marketing_url])],
      ["Reviews", base_url("/reviews/", base_url: Capybara.app.config[:marketing_url])],

      # Partners:
      ["Sharesight Business", base_url("/business/", base_url: Capybara.app.config[:marketing_url])],
      ["Partner Directory", base_url("/partners/", base_url: Capybara.app.config[:marketing_url])],
      ["Become a Partner", base_url("/become-a-partner/", base_url: Capybara.app.config[:marketing_url])],
      ["Become an Affiliate", base_url("/affiliates/", base_url: Capybara.app.config[:marketing_url])],
      ["Sharesight API", Capybara.app.config[:api_url]],
      ["sales@sharesight.com", 'mailto:sales@sharesight.com'],

      # Resources:
      ["Help Centre", Capybara.app.config[:help_url]],
      ["Community Forum", Capybara.app.config[:community_url]],
      ["Blog", base_url("/blog/", base_url: Capybara.app.config[:marketing_url])],
      ["Webinars & Events", base_url("/events/", base_url: Capybara.app.config[:marketing_url])],
      ["Privacy Policy", base_url("/privacy-policy/", base_url: Capybara.app.config[:marketing_url])],
      ["Terms of Use", base_url("/sharesight-terms-of-use/", base_url: Capybara.app.config[:marketing_url])],
      ["Business Terms of Use", base_url("/sharesight-professional-terms-of-use/", base_url: Capybara.app.config[:marketing_url])],

      # locales:
      ["Global", base_url('/')],
      ["Australia", base_url('/au/')],
      ["Canada", base_url('/ca/')],
      ["New Zealand", base_url('/nz/')],
      ["United Kingdom", base_url('/uk/')],
    ]

    expect(links.length).to eq(expected_links.length)

    # iterate through all links on the page and find
    links.each do |link|
      matched_link = expected_links.find do |expected_link|
        link.text.match(expected_link[0])
      end

      expect(matched_link).to_not(be_nil, "Unexpected link '#{link.text}'!")

      expected_href = matched_link[1]
      if expected_href
        expect(link[:href]).to(match(expected_href), "Link '#{link.text}' did not match expected href of '#{expected_href}'.  Received '#{link[:href]}' instead.")
      end

      expected_links.delete(matched_link)
    end


    expect(expected_links.length).to(eq(0), "Found leftover links in expected_links: #{expected_links}")
  end
end
