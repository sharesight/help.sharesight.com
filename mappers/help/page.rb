# This normalizes the data coming from contentful, so a user enters ' Great   Title!' and it becomes 'Great Title!'
# Adds url slugs.
class HelpPageMapper < ContentfulMiddleman::Mapper::Base
  def map(context, entry)
    super

    # Adds a "content available in locales" field to the page; NOTE: 'en' is available in all locales.
    context.content_langs = context&.content&.keys
    context.content_langs = ['en'] if context.content_langs.blank?

    # some sanitizing of blog content
    context.content = (context.content || '')
      .gsub('.png)', '.png?w=917)') # restrict image width
      .gsub('.jpg)', '.jpg?w=917)')

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
