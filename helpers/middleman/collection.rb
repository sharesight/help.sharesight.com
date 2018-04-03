require 'ostruct'
load File::expand_path('../config_helper.rb', __dir__)

module MiddlemanCollectionHelpers
  def page_url(page, locale_id: default_locale_id)
    return localize_url(ConfigHelper::help_page_url_slug(page), locale_id: locale_id)
  end

  def category_url(category, locale_id: default_locale_id)
    return localize_url(ConfigHelper::help_category_url_slug(category), locale_id: locale_id)
  end

  def page_collection(lang = default_locale_obj[:lang], with_associations: false)
    collection = data.help.pages
      .map{ |tuple| tuple[1] }
      .map{ |model| localize_entry(model, lang, default_locale_obj[:lang]) }
      .select{ |model| is_valid_page?(model) }
      .sort{ |a, b| sort_pages(a, b) }

    if with_associations
      collection = collection.map do |page|
        category.child_pages = page_ccollection(lang, with_associations: false)
          .select{ |child_page| child_page[:parent_page][:id] == page[:id] }
          .sort{ |a, b| sort_pages(a, b) }

        page
      end
    end

    collection
  end

  def categories_collection(lang = default_locale_obj[:lang], with_associations: false)
    collection = data.help.categories
      .map{ |tuple| tuple[1] }
      .map{ |model| localize_entry(model, lang, default_locale_obj[:lang]) }
      .select{ |model| is_valid_category?(model) }
      .sort{ |a, b| sort_categories(a, b) }

    if with_associations
      collection = collection.map do |category|
        category[:pages] = page_collection(lang, with_associations: true)
          .select{ |page| page[:category][:id] == category[:id] }
          .sort{ |a, b| sort_pages(a, b) }

        category
      end
    end

    collection
  end

  private

  def is_valid_page?(model)
    return !!(
      model && !model[:name].blank? && !model[:url_slug].blank?
    ) rescue false
  end

  def is_valid_category?(model)
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
