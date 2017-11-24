module BreadcrumbHelper

  def self.parent_slug(data, page, cp)
    found_page = find_page_id(data, page)
    url_slug = found_page.last.dig("url_slug", "en")
    return "#{RegionHelper::locale_from_url(cp)}/#{url_slug}/".squeeze('/') if !url_slug.nil?

    title = found_page.last.dig("title", "en")
    return "#{RegionHelper::locale_from_url(cp)}/#{title.downcase.gsub(' ', '-')}/".squeeze('/')
  end

  def self.parent(data, page)
    find_page_id(data, page).last.dig("title", "en")
  end

  def self.child(page)
    page.last.title&.en&.to_s if page.last.title
  end

  private

  def self.find_page_id(data, page)
    data.help_pages.page.find {|n| n.last.id == parent_id(page)}
  end

  def self.parent_id(page)
    page.last[:parent_page].dig("en", "sys", "id")
  end
end
