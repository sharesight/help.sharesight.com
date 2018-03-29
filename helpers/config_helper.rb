require 'date'
require 'string-urlize'

module ConfigHelper

  def self.help_page_name(current_page)
    # puts current_page
    current_page.split('/').last.gsub('.html','')
  end

  def self.help_post_url_slug(page)
    return page&.url_slug.en.sub(%r{^/}, "").sub(%r{/$}, "") if page&.url_slug&.en
    slugify page.title.en
  end

  def self.help_category_url_slug(category)
    slugify category.name.en
  end

  def self.slugify(page_name)
    page_name.to_s.strip.downcase.urlize.gsub('--', '-')
  end

  def self.space_slugify(page_name)
    page_name.to_s.strip.urlize.downcase.gsub(" ", "-")
  end

  def self.get_locale_from_url(current_page_url)
    cpu = current_page_url.split('/')
    if cpu.count > 2 && cpu.drop(1).first.length == 2
      "/#{cpu.drop(1).first}"
    else
      ""
    end
  end
end
