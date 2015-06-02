module ReformattingHelper

  def link_to_reformatting_url(url)
    puts url.inspect
    return "No" if !url || url.empty?
    url = "http://#{url}" if !url.match(/^http[s]?:\/\//)

    link_to('Yes', url, target: '_blank')
  end


  def print_reformatting_url(url)
    return "No" if !url || url.empty?
    url
  end
end
