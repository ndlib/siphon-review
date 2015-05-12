class AlibrisSearchLink
  include RailsHelpers

  def initialize(title)
    @title = title
  end

  def link
    helpers.link_to "Alibris", url, target: '_blank'
  end

  private

    def url
      "http://www.alibris.com/booksearch?mtype=B&hs.x=0&hs.y=0&hs=Submit&keyword=#{CGI.escape("#{title}")}"
    end


    def title
      @title.gsub('...', '')
    end
end
