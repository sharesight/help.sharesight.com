class Minitest::Test
  def fake_object(options = {})
    page = OpenStruct.new
    options.each do |key, value|
      if value.is_a? Hash
        page[key] = fake_object(value)
      else
        page[key] = value
      end
    end
    page
  end
end
