require "json"

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
    @json_result["display"]["title"].to_s.truncate(250, :separator => ' ')
  end


  def type
    @json_result['type'].downcase
  end


  def creator_contributor
    @json_result['display']['creator_contributor'].to_s.truncate(250, :separator => ' ')
  end


  def details
    @json_result['display']['details'].to_s.truncate(250, :separator => ' ')
  end


  def publisher_provider
    @json_result['display']['publisher_provider'].to_s.truncate(250, :separator => ' ')
  end


  def availability
    @json_result['display']['availability']
  end


  def available_library
    @json_result['display']['available_library']
  end


  def fulltext_available?
    @json_result['fulltext_available']
  end


  def fulltext_url
    @json_result['links']['fulltext_url']
  end


  def number_of_loans
    holdings['number_of_loans']
  end


  def oclc_number
    @json_result['oclc']
  end


  def frbr_group_id
    @json_result['primo']['facets']['frbrgroupid']
  end


  private

    def make_request(id)
      API::Resource.search_catalog(id)
    end


    def holdings
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
