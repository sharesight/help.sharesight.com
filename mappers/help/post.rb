# This normalizes the data coming from contentful, so a user enters ' Great   Title!' and it becomes 'Great Title!'
# Adds url slugs.
class HelpPostMapper < ContentfulMiddleman::Mapper::Base
  def map(context, entry)
    super
    keys = entry.fields_with_locales.keys

    if keys.include?(:updatedAt)
      context.last_updated_at = map_locales(context.updatedAt){ |value| value.strftime("%B %-d, %Y") } rescue entry.name
    end
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
