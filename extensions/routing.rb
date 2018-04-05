module Middleman
  class Routing < Extension
    def initialize(app, options_hash={}, &block)
      super
    end

    def after_configuration
      # ensure this doesn't run before data is available; if it never runs, it will fail tests
      if !app.data || !app.data.respond_to?('help') || !app.data.help.respond_to?('categories') || !app.data.help.respond_to?('pages')
        puts "WARNING: Not routing as middleman contentful has not been ran!  Please ensure middleman contentful runs successfully first."
        return
      end

      generic_file_extensions()

      app.data.locales.each do |locale|
        contents(locale)
        proxy_help_pages(locale)
        proxy_pages(locale)
        sitemaps(locale)
      end
    end

    private

    def generic_file_extensions()
      # Routing Overrides
      app.page '/*.xml', :locals => { locale_obj: app.default_locale_obj }, layout: false
      app.page '/*.json', :locals => { locale_obj: app.default_locale_obj }, layout: false
      app.page '/*.txt', :locals => { locale_obj: app.default_locale_obj }, layout: false
    end

    def sitemaps(locale)
      localize_static_file('sitemap.xml', locale)
    end

    def contents(locale)
      localize_static_file('contents.json', locale)
    end

    def proxy_help_pages(locale)
      collection = app.pages_collection(locale[:lang])

      collection.each do |page|
        app.proxy(
          path_for_proxy(app.page_path(page, locale_id: locale[:id])),
          "help-page.html",
          locals: { locale_obj: locale, page: page },
          ignore: true
        )
      end
    end

    def proxy_pages(locale)
      # pages from data/locales.json
      locale.pages.select{ |page| page.proxy.nil? || page.proxy == true }.each do |page|
        app.proxy path_for_proxy(page[:page], locale[:id]), "page-#{page[:page]}.html", :locals => { locale_obj: locale }, ignore: true
      end
    end

    # It's valid to send no locale_id, eg. if you've already localized the page via localize_path.
    def path_for_proxy(slug, locale_id = '', is_html = true)
      base = (locale_id != app.default_locale_id) ? "#{locale_id}" : ''

      newPath = "#{base}/#{slug}"
      newPath = newPath.sub(/\/$/, '') + '.html' if is_html # ensure we do slug.html and not slug/.html
      newPath = newPath.squeeze('/')
      return newPath
    end

    def localize_static_file(filename, locale)
      # We cannot proxy sitemap.xml to itself, but we still want the locale_obj, so we use app.page
      if locale[:id] != app.default_locale_id
        app.proxy path_for_proxy(filename, locale[:id], false), filename, :locals => { locale_obj: locale }, layout: false, ignore: false
      end
    end
  end
end

::Middleman::Extensions.register(:routing, ::Middleman::Routing)
