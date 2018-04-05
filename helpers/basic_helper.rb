module BasicHelper
  # Parsing out quotes for contentful => html.
  def self.replace_quotes(str)
    str&.gsub(/"/, "'")
  end
end
