module ReformattingHelper

  def link_to_reformatting_url(url)
    url.present? ? link_to('Yes', url, target: '_blank') : 'No'
  end

end
