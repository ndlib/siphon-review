class FrbrGroupSearchLink

  include RailsHelpers

  def initialize(frbr_group_id, document_id)
    @frbr_group_id = frbr_group_id
    @document_id = document_id
  end


  def link
    helpers.link_to "Catalog Search", url, target: '_blank'
  end


  def url
    "http://onesearch.library.nd.edu/primo-explore/search?query=any,contains,#{@document_id}&institution=NDU&vid=NDU&tab=nd_campus&search_scope=nd_campus&mode=basic&displayMode=full&bulkSize=10&highlight=true&dum=true&displayField=all&pcAvailabiltyMode=true"
  end

end
