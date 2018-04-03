module Middleman
  class Routing < Extension
    def initialize(app, options_hash={}, &block)
      super
    end

    def after_configuration
      generic_file_extensions()

      app.data.locales.each do |locale|
        app.config[:locale_obj] = locale

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
      app.proxy path_for_proxy('sitemap.xml', locale[:id]), "sitemap.xml", :locals => { locale_obj: locale }, layout: false, ignore: true
    end

    def contents(locale)
      # Expose contents.json in all locales
      app.proxy path_for_proxy('contents.json', locale[:id]), "contents.json", :locals => { locale_obj: locale }, layout: false, ignore: true
    end

    def proxy_help_pages(locale)
      collection = app.page_collection(locale[:lang])

      collection.each do |page|
        app.proxy(
          path_for_proxy(ConfigHelper.help_page_url_slug(page), locale[:id]),
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

    def path_for_proxy(slug, locale_id)
      base = (locale_id != app.default_locale_id) ? "#{locale_id}/" : ''

      newPath = "#{base}/#{slug}"

      newPath += '.html'
      newPath = newPath.squeeze('/')
      return newPath
    end
  end
end

::Middleman::Extensions.register(:routing, ::Middleman::Routing)
