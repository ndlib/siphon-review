

class HathiTrustSearchLink
  include RailsHelpers

  def initialize(title)
    @title = title
  end

  def link
    helpers.link_to "Hathi Trust", url, target: '_blank'
  end

  private

    def url
      "http://babel.hathitrust.org/cgi/ls?field1=ocr;q1=#{CGI.escape(title)};a=srchls;lmt=ft"
    end


    def title
      @title.gsub('...', '')
    end
end
