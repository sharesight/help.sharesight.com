# This normalizes the data coming from contentful, so a user enters ' Great   Title!' and it becomes 'Great Title!'
# Adds url slugs.
class HelpPageMapper < ContentfulMiddleman::Mapper::Base
  def map(context, entry)
    super

    # Adds a "content available in locales" field to the page; NOTE: 'en' is available in all locales.
    context.content_locales = context&.content&.keys
    context.content_locales = ['en'] if context.content_locales.blank?

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
