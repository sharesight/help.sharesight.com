# This normalizes the data coming from contentful.

class HelpPageMapper < ContentfulMiddleman::Mapper::Base
  def map(context, entry)
    super

    # Adds a "content available in locales" field to the page; NOTE: 'en' is available in all locales.
    context.content_langs = context&.content&.keys
    context.content_langs = ['en'] if context.content_langs.blank?

    keys = entry.fields_with_locales.keys

    if keys.include?(:content)
      context.content = map_locales(context.content) do |content|
        (content || '')
          .gsub('.png)', '.png?w=917)') # restrict image width
          .gsub('.jpg)', '.jpg?w=917)')
          .gsub('//images.contentful.com/', '//images.ctfassets.net/') # redirect old assets
          .gsub('//assets.contentful.com/', '//assets.ctfassets.net/') # see: https://www.contentful.com/blog/2017/12/08/change-of-the-contentful-asset-domain/
          .gsub('//downloads.contentful.com/', '//downloads.ctfassets.net/')
          .gsub('//videos.contentful.com/', '//videos.ctfassets.net/')
      end rescue entry.try(:content)
    end

    return context
  end

  def map_locales(entry, &block)
    # TODO: Maybe take some of the logic from contentful_middleman/mappers

    return block.call(entry) unless entry.is_a?(::Hash)
    mapped_entry = ::Thor::CoreExt::HashWithIndifferentAccess.new
    entry.each do |field, value|
      mapped_entry[field] = block.call(value)
    end

    return mapped_entry
  end
end
