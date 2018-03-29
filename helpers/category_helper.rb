module CategoryHelper

  # Returns the help pages, ordered for the navigation menu
  # The structure is
  # [
  #   "category1_id" => {
  #      "category_name": "name1",
  #      "category_url": "url1",
  #      "category_description": "description",
  #      "pages": [
  #        {
  #          "id": "id2",
  #          "page_title": "title2",
  #          "page_url": "url2",
  #          "subpages": [
  #            [
  #              "subpage3_id",
  #              "subpage3_title",
  #              "subpage3_url"
  #            ],
  #            ... (more subpages, in order)
  #          ]
  #        },
  #        ... (more help pages in this category, in order)
  #      ]
  #    }
  #   ... (more categories, in order)
  # ]
  #

  def self.navigation_menu_structure(data, locale = "en")
    menu = []
    # first sort categories and add their details
    data.help_categories.category.each do |id, category|
      category_entry = {}
      category_entry["#{id}"] = {
        "category_name": category["name"][locale],
        "category_url": ConfigHelper.help_category_url_slug(category),
        "category_description": category.dig("description", locale),
        "pages": pages_in_category(data, category, locale),
        "category_slug": category
      }
      menu << category_entry
    end
    menu.sort { |a, b| compare_categories_for_menu(a, b, locale) }
    return menu
  end

  def self.pages_in_category(data, category, locale = "en")
    category_pages = data.help_pages.page.values.select { |page| page.dig("category", locale, "sys", "id") == category.id}
    category_pages.sort! { |a, b| compare_pages_for_menu(a, b, locale)}
    result_pages = []
    category_pages.each do |page|
      result_pages << {
        "id": page.id,
        "page_title": page.dig("title", locale),
        "page_url": ConfigHelper.help_post_url_slug(page),
        "subpages": subpages_for_page(data, page, locale),
        "has_parent": !page.dig("parent_page").blank?,
        "content": page.dig("content")
      }
    end
    result_pages
  end

  def self.subpages_for_page(data, page, locale)
    page_subpages = data.help_pages.page.values.select { |subpage| subpage.dig("parent_page", locale, "sys", "id") == page.id}
    page_subpages.sort! { |a, b| compare_pages_for_menu(a, b, locale)}
    result_subpages = []
    page_subpages.each do |subpage|
      result_subpages << [
        "#{subpage.id}",
        "#{subpage.dig("title", locale)}",
        "#{ConfigHelper.help_post_url_slug(subpage)}"
      ]
    end
    result_subpages
  end

  def self.compare_pages_for_menu(a, b, locale = "en")
    compare_generic(a, b, "title", locale)
  end

  def self.compare_categories_for_menu(a, b, locale = "en")
    compare_generic(a, b, "name", locale)
  end

  def self.compare_generic(a, b, secondary_sort_field, locale = "en")
    a_order = a["order"] ? a["order"][locale].to_i : 100
    b_order = b["order"] ? b["order"][locale].to_i : 100
    return a.dig(secondary_sort_field, locale) <=> b.dig(secondary_sort_field, locale) if a_order == b_order
    a_order <=> b_order
  end
end
