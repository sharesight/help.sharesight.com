module RegionHelper

  def self.locale_from_url(current_page)
    url = current_page.split('/')

    if url.length == 0
      ""
    elsif url.length == 2 && url[1].length > 2
      ""
    elsif url.length == 2 && url[1].length == 2
      "/#{url[1]}/"
    elsif url.length == 3 && url[1].length == 2
      "/#{url[1]}"
    end
  end

  def self.page_meta_by_region(data, region, path)
    data.select {|x| x[:id] == region}.first[:pages].select {|x| x[:page] == 'index.html'.gsub('.html','')}
  end

  def self.filler_region(region)
    if region == ""
      "usa"
    else
      region
    end
  end
end
