require "json"
include DictionaryHelper

class DiscoveryApi
  attr_accessor :json_result, :id

  def self.search_by_id(id)
    DiscoveryApi.new(id)
  end


  def data
    {
      title: title,
      type: type,
      creator_contributor: creator_contributor,
      details: details,
      publisher_provider: publisher_provider,
      fulltext_available?: fulltext_available?,
      fulltext_url: fulltext_url.to_s,
      type: type.to_s
    }
  end


  def initialize(id)
    @id = fix_id(id)
    @json_result = make_request(@id)
  end


  def title
    get_hierarchy(@json_result, ["display", "title"], "").to_s.truncate(250, :separator => ' ')
  end


  def type
    get(@json_result, 'type', "").downcase
  end


  def creator_contributor
    get_hierarchy(@json_result, ['display', 'creator_contributor'], "").to_s.truncate(250, :separator => ' ')
  end


  def details
    get_hierarchy(@json_result, ['display', 'details'], "").to_s.truncate(250, :separator => ' ')
  end


  def publisher_provider
    get_hierarchy(@json_result, ['display', 'publisher_provider'], "").to_s.truncate(250, :separator => ' ')
  end


  def availability
    get_hierarchy(@json_result, ['display', 'availability'], "")
  end


  def available_library
    get_hierarchy(@json_result, ['display', 'available_library'], "")
  end


  def fulltext_available?
    get(@json_result, 'fulltext_available', false)
  end


  def fulltext_url
    get_hierarchy(@json_result, ['links', 'fulltext_url'], "")
  end


  def number_of_loans
    get(holdings, 'number_of_loans', "0")
  end


  def oclc_number
    get(@json_result, 'oclc', "0")
  end


  def frbr_group_id
    get_hierarchy(@json_result, ['primo', 'facets', 'frbrgroupid'], nil)
  end

  def check_record
    # these are the two base elements that must be present
    check_dictionary_flat(@json_result, ['primo', 'display'], "#{@id}", true)
  end

  private

    def make_request(id)
      API::Resource.search_catalog(id)
    end


    def holdings
      if !check_dictionary_key(@json_result, 'holdings', "#{@id}") then
        return nil
      end
      @holdings ||= @json_result['holdings'].find { | record | record['record_id'] == @id }
    end


    def fix_id(id)
      if id.match(/ndu_aleph/)
        id
      else
        "ndu_aleph#{id.rjust(9, "0")}"
      end
    end

end
