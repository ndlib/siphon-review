

class BooksInPrintSearchLink
  include RailsHelpers

  def initialize(title)
    @title = title
  end

  def link
    helpers.link_to "Books In Print", url, target: '_blank'
  end

  private

    def url
      "http://www.booksinprint.com/SearchResults.aspx?q=quicksearch-all%3A%5B#{CGI.escape(title)}%5D&op=1&qs=1"
    end


    def title
      @title.gsub('...', '')
    end
end
