require 'ostruct'

module MiddlemanCollectionHelpers
  def page_url(page, locale_id: default_locale_id, base_url: config[:base_url])
    path = if page[:url_slug]
      page[:url_slug].sub(%r{^/}, "").sub(%r{/$}, "")
    else
      page[:title].to_s.strip.downcase.urlize.gsub('--', '-')
    end

    localize_url(path, locale_id: locale_id, base_url: base_url)
  end

  def page_path(page, locale_id: default_locale_id)
    page_url(page, locale_id: locale_id, base_url: '')
  end

  def category_url(category, locale_id: default_locale_id, base_url: config[:base_url])
    return page_url(category[:pages].first, locale_id: locale_id, base_url: base_url) if !category[:pages].blank?

    pages = page_collection(get_locale_obj(locale_id)[:lang], with_associations: false)
      .select{ |page| page[:category] && page[:category][:id] == category[:id] }
      .sort{ |a, b| sort_pages(a, b) }

    return page_url(pages.first, locale_id: locale_id, base_url: base_url) if pages.length
    raise "No valid URL found for #{category[:id]} – ensure this category has associated pages."
  end

  def category_path(category, locale_id: default_locale_id)
    category_url(category, locale_id: locale_id, base_url: '')
  end

  def page_collection(lang = default_locale_obj[:lang], with_associations: false)
    collection = data.help.pages
      .map{ |tuple| tuple[1] }
      .map{ |model| localize_entry(model, lang, default_locale_obj[:lang]) }
      .select{ |model| is_valid_page_model?(model) }

    if with_associations
      collection = collection.map do |page|
        page[:child_pages] = page_collection(lang, with_associations: false)
          .select{ |child_page| child_page[:parent_page] && child_page[:parent_page][:id] == page[:id] }

        page
      end
    end

    collection.sort{ |a, b| sort_pages(a, b) }
  end

  def categories_collection(lang = default_locale_obj[:lang], with_associations: false)
    collection = data.help.categories
      .map{ |tuple| tuple[1] }
      .map{ |model| localize_entry(model, lang, default_locale_obj[:lang]) }
      .select{ |model| is_valid_category_model?(model) }

    if with_associations
      collection = collection.map do |category|
        category[:pages] = page_collection(lang, with_associations: false)
          .select{ |page| page[:category] && page[:category][:id] == category[:id] }

        category
      end

      # Filter out categories without pages if with_associations = true
      collection = collection.select{ |model| model[:pages].length }
    end

    collection.sort{ |a, b| sort_categories(a, b) }
  end

  private

  def is_valid_page_model?(model)
    return !!(
      model && !model[:title].blank? && !model[:url_slug].blank?
    ) rescue false
  end

  def is_valid_category_model?(model)
    return !!(
      model && !model[:name].blank?
    ) rescue false
  end

  def generic_sort(a, b, secondary_sort_field = 'id')
    a_order = a[:order] || 0
    b_order = b[:order] || 0
    return (a[secondary_sort_field] || '')&.strip&.downcase <=> (b[secondary_sort_field] || '')&.strip&.downcase if b_order == a_order
    b_order <=> a_order
  end

  def sort_categories(a, b)
    generic_sort(a, b, 'name')
  end

  def sort_pages(a, b)
    generic_sort(a, b, 'title')
  end
end
