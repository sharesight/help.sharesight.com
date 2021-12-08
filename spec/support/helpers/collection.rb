require 'cgi'

module CapybaraCollectionHelpers
  def get_pages(locale_obj = Capybara.app.default_locale_obj)
    pages = Capybara.app.data.help.pages.map{ |tuple| tuple[1] }
    pages = pages.map do |page|
      page = Capybara.app.localize_entry(page, locale_obj[:lang], Capybara.app.default_locale_obj[:lang])
      page = OpenStruct.new(page) # hash does not like being mutable

      page[:url] = Capybara.app.page_url(page, locale_id: locale_obj[:id])
      page[:path] = Capybara.app.page_path(page, locale_id: locale_obj[:id])

      # The browser will do this when it parses `&amp; => &`
      page[:title] = page[:title] && CGI::unescapeHTML(page[:title])
      page[:meta_description] = page[:meta_description] && CGI::unescapeHTML(page[:meta_description])

      # Mimic layouts/partials/head
      page[:page_title] = "#{BasicHelper.replace_quotes(page[:title])} | #{locale_obj[:append_title]}"
      page[:description] = BasicHelper.replace_quotes(page[:meta_description])
      page
    end

    pages = pages.select{|page| Capybara.app.is_valid_page_model?(page)}
    pages
  end

  def get_categories(locale_obj = Capybara.app.default_locale_obj)
    categories = Capybara.app.data.help.categories.map{ |tuple| tuple[1] }
    categories = categories.select{ |category| category && category[:name] } # only categories with a truthy name
    categories = categories.map{ |category| Capybara.app.localize_entry(category, locale_obj[:lang], Capybara.app.default_locale_obj[:lang]) }

    categories = categories.map do |category|
      category[:url] = Capybara.app.category_url(category, locale_id: locale_obj[:id])
      category[:path] = Capybara.app.category_path(category, locale_id: locale_obj[:id])
      category
    end

    categories = categories
      .select{|category| Capybara.app.is_valid_category_model?(category)}
      .select{ |category| !(category[:id] === '5OiSIUarvyOi84yWQwE4S' || category[:name] === 'Miscellaneous') } # Filter out the "Miscellaneous" category:

    categories
  end
end
