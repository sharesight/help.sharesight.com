module MiddlemanLocaleHelpers
  # Locale Helpers
  def default_locale_id
    return config[:default_locale_id] # set in config.rb
  end

  def default_locale_obj
    return @default_locale_obj if !@default_locale_obj.nil?

    @default_locale_obj = get_locale_obj(default_locale_id)
    return @default_locale_obj
  end

  def current_locale_id
    locale_id = default_locale_id # default to the default id
    locale_id = current_path_array[0] if is_valid_locale_id?(current_path_array[0])

    return locale_id&.downcase
  end

  def current_locale_obj
    return get_locale_obj(current_locale_id)
  end

  def locale_obj
    # using rescue as there's no `dig` method on current_page.
    current_page.metadata[:locals][:locale_obj] || current_page.metadata[:options][:locals][:locale_obj] || current_locale_obj rescue current_locale_obj
  end

  def is_current_locale_id?(locale_id)
    locale_id = locale_id&.downcase
    return current_locale_id == locale_id
  end

  def get_locale_obj(locale_id = current_locale_id )
    locale_id = locale_id&.downcase

    obj = data.locales.find { |x| x[:id] == locale_id }
    raise Exception.new("Missing locale data for #{locale_id}.") if obj.nil? || obj[:id].nil?
    return obj || {} # default to an empty hash
  end

  def is_valid_locale_id?(locale_id)
    locale_id = locale_id&.downcase
    return !!data.locales.find { |x| x[:id] == locale_id }
  end

  def locale_cert_type(obj = current_locale_obj)
    get_locale_obj(obj[:id])&.cert_type&.to_s || 'stock'
  end
end
