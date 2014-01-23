class WorldCatOclcNumberLink
  include RailsHelpers

  def initialize(oclc_number)
    @oclc_number = oclc_number
  end


  def link
    if @oclc_number.present?
      helpers.link_to 'World Cat', "http://www.worldcat.org/search?q=no%3A#{@oclc_number}", target: '_blank'
    else
      ""
    end
  end

end
