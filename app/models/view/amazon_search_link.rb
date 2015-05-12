class AmazonSearchLink
  include RailsHelpers

  def initialize(title)
    @title = title
  end

  def link
    helpers.link_to "Amazon", url, target: '_blank'
  end

  private

    def url
      "http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=#{CGI.escape("#{title}")}"
    end


    def title
      @title.gsub('...', '')
    end
end
