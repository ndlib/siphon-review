class AbeBooksSearchLink
  include RailsHelpers

  def initialize(title)
    @title = title
  end

  def link
    helpers.link_to "Abe Books", url, target: '_blank'
  end

  private

    def url
      "http://www.abebooks.com/servlet/SearchResults?sts=t&tn=#{CGI.escape("#{title}")}"
    end


    def title
      @title.gsub('...', '')
    end
end
