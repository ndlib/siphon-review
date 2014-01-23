class FrbrGroupSearchLink

  include RailsHelpers

  def initialize(frbr_group_id, document_id)
    @frbr_group_id = frbr_group_id
    @document_id = document_id
  end


  def link
    helpers.link_to "FRBR Group", url, target: '_blank'
  end


  def url
    "http://onesearch.library.nd.edu/primo_library/libweb/action/dlSearch.do?cs=frb&frbg=#{@frbr_group_id}&fctN=facet_frbrgroupid&fctV=#{@frbr_group_id}&doc=#{@document_id}&dscnt=0&onCampus=false&query=any%2Ccontains%2C#{@frbr_group_id}&tab=nd_campus&dym=true&highlight=true&ct=search&mode=Basic&search_scope=nd_campus&vl(16833498UI0)=any&indx=1&displayField=title&bulkSize=10&vl(freeText0)=catcher#{@frbr_group_id}&fn=search&vid=NDU&institution=NDU"
  end
end
