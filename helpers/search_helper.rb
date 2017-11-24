require 'stopwords'

module SearchHelper
  def self.condense_content(original_content)
    filter = Stopwords::Snowball::Filter.new "en"
    filter.filter(original_content.split).join(" ")
  end
end
