

class InternetArchiveSearchLink
  include RailsHelpers

  def initialize(title)
    @title = title
  end

  def link
    helpers.link_to "Internet Archive", url, target: '_blank'
  end

  private

    def url
      "https://archive.org/search.php?query=#{CGI.escape("title(#{title})")}"
    end


    def title
      @title.gsub('...', '')
    end
end
