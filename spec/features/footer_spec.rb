require 'spec_helper'

describe 'Footer', type: :feature do
  it 'should have the correct links' do
    [
      /^www.sharesight.com/,
      /^About Us/,
      /^Pricing/,
      /^Reviews/,
      /^Affiliates/,
      /^FAQ/,
      /^Blog/,
      /^Partners/,
      /^Developer API/,
      /^Privacy Policy/,
      /^Terms of Use/,
      /^Pro Terms of Use/,
    ].each do |text|
      visit '/'
      expect(page.find('a.footer__link', text: text)).to_not be_nil
    end
  end
end
