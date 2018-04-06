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
    return page_url(category[:pages].first, locale_id: locale_id, base_url: base_url) if category[:pages]&.first

    pages = pages_collection(get_locale_obj(locale_id)[:lang])
      .select{ |page| page[:category] && page[:category][:id] == category[:id] }
      .sort{ |a, b| sort_pages(a, b) }

    return page_url(pages.first, locale_id: locale_id, base_url: base_url) if pages&.first
    raise "No valid URL found for #{category[:id]} – ensure this category has associated pages."
  end

  def category_path(category, locale_id: default_locale_id)
    category_url(category, locale_id: locale_id, base_url: '')
  end

  def pages_collection(lang = default_locale_obj[:lang], with_associations = true)
    return get_cached_collection('pages', lang, with_associations) if get_cached_collection('pages', lang, with_associations)

    collection = data.help.pages
      .map{ |tuple| tuple[1] }
      .map{ |model| localize_entry(model, lang, default_locale_obj[:lang]) }
      .select{ |model| is_valid_page_model?(model) }

    # add child pages (depth = 1)
    if with_associations
      collection = collection.map{ |page|
        # This is recursive, but it should get cached..
        page[:child_pages] = pages_collection(lang, false).select{ |child_page| child_page[:parent_page] && child_page[:parent_page][:id] == page[:id]}
        page
      }
    end

    collection = collection.sort{ |a, b| sort_pages(a, b) }

    set_cached_collection(collection, 'pages', lang, with_associations)
    collection
  end

  def categories_collection(lang = default_locale_obj[:lang], with_associations = true, restrict_children = true)
    return get_cached_collection('categories', lang, with_associations) if get_cached_collection('categories', lang, with_associations)

    collection = data.help.categories
      .map{ |tuple| tuple[1] }
      .map{ |model| localize_entry(model, lang, default_locale_obj[:lang]) }
      .select{ |model| is_valid_category_model?(model) }

    # add associated pages, with children
    if with_associations
      collection = collection.map{ |category|
        category[:pages] = pages_collection(lang, true).select{ |page| page[:category] && page[:category][:id] == category[:id] }
        category
      }

      collection = collection.select{ |model| model[:pages].length } if restrict_children
    end

    collection = collection.sort{ |a, b| sort_categories(a, b) }

    set_cached_collection(collection, 'categories', lang, with_associations)
    collection
  end

  def page_content_locales(page)
    page&.content_langs&.map{|lang| data.locales.find{|locale| locale[:lang].to_s == lang.to_s}}&.select{|locale| locale} || []
  end

  def is_valid_page_model?(model)
    return !!(
      model &&
      # it's posible to not have a localized version for content, so don't attempt to render it in that locale
      # when we don't have a lang, eg. looking for 'en' or 'en-NZ', but only 'en-CA' is listed, content will result in a hash: {'en-CA': …}
      !model[:title]&.blank? && model[:title].is_a?(String) &&
      !model[:content]&.blank? && model[:content].is_a?(String) &&
      !model[:category]&.blank? && model[:category][:id]
    ) rescue false
  end

  def is_valid_category_model?(model)
    return !!(
      model && !model[:name]&.blank?
    ) rescue false
  end

  private

  # Caching is based off of a "hash" of key, lang, with_associations
  def get_cached_collection(key, lang, with_associations)
    @cached_collection ||= {}
    return @cached_collection[key][lang][with_associations] if @cached_collection.dig(key, lang, with_associations)
    false
  end

  def set_cached_collection(collection, key, lang, with_associations)
    @cached_collection ||= {}
    @cached_collection[key] ||= {}
    @cached_collection[key][lang] ||= {}
    @cached_collection[key][lang][with_associations] = collection
    collection
  end

  def generic_sort(a, b, secondary_sort_field = 'id')
    a_order = a[:order] || 100
    b_order = b[:order] || 100
    return (a[secondary_sort_field] || '')&.strip&.downcase <=> (b[secondary_sort_field] || '')&.strip&.downcase if b_order == a_order
    a_order <=> b_order
  end

  def sort_categories(a, b)
    generic_sort(a, b, 'name')
  end

  def sort_pages(a, b)
    generic_sort(a, b, 'title')
  end
end
