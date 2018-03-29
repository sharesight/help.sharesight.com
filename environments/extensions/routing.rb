module Middleman
  class Routing < Extension
    def initialize(app, options_hash={}, &block)
      super
    end

    def after_configuration
      route()
      proxy_pages()
      sitemaps()
    end

    private

    def sitemaps()
      app.data.locales.each do |locale|
        app.config[:locale_obj] = locale
        app.proxy "/#{locale[:id]}/sitemap.xml", "sitemap.xml", :locals => { locale_obj: locale }, ignore: false
      end
    end

    def route()
      # Routing Overrides
      app.page '/*.xml', layout: false
      app.page '/*.json', layout: false
      app.page '/*.txt', layout: false
    end

    def proxy_help_posts()
      app.data.locales.each do |locale_obj|
        collection = app.data.help.posts.each
        collection = collection.map{ |tuple| localize_entry(tuple[1], locale_obj[:lang], default_locale_obj[:lang]) }
        collection = collection.select{ |post| post[:content] }

        collection.each do |post|
          app.proxy(
            path_for_proxy(ConfigHelper.help_post_url_slug(post), locale_obj[:id]),
            "post.html",
            locals: { locale_obj: locale_obj, post: post },
            ignore: true
          )
        end
      end
    end

    def proxy_pages()
      # pages from data/locales.json
      app.data.locales.each do |locale|
        app.config[:locale_obj] = locale
        locale.pages.select{ |page| page.proxy.nil? || page.proxy == true }.each do |page|
          path = ''
          path += "/#{locale.id}" if locale.id != app.default_locale_id
          path += "/#{page[:page]}" if page[:page] != 'index'
          path += '/index.html'

          app.proxy path, "page-#{page[:page]}.html", :locals => { locale_obj: locale }, ignore: true
        end
      end
    end

    private

    def path_for_proxy(slug, locale_id)
      base = (locale_id != app.default_locale_id) ? "#{locale_id}/" : ''

      newPath = "#{base}/#{path}"

      newPath += '.html'
      newPath = newPath.squeeze('/')
      return newPath
    end
  end
end

::Middleman::Extensions.register(:routing, ::Middleman::Routing)
