require 'net/http'
require 'uri'
require 'nokogiri'


class AlephReformattingImporter

  def import!
    begin
      xml = xml_from_source
      parse_xml(xml).each do | record |
        item = parse_attributes(record)
        AlephReformattingImport.new(item).import!
      end
    rescue Exception => e
      # log error
      puts "error"
      raise e
    end
  end


  def xml_from_source
    url = URI.parse(file_name)
    Net::HTTP.start(url.host, url.port) do |http|
      get = Net::HTTP::Get.new(url.request_uri)
      response = http.request(get)
      response.body
    end
  end


  def parse_xml(xml_string)
    Nokogiri.parse(xml_string).xpath('//printout/bib')
  end


  def parse_attributes(record)
    ret = {}
    ret[:title] = record.at('z13-title').text
    ret[:document_number] = record.at('z13-doc-number').text
    item = record.at('item')
    ret[:call_number] = item.at('z30-call-no').text
    ret[:barcode] = item.at('z30-barcode').text

    ret
  end


  def file_name
    "http://alephprod.library.nd.edu/app_tmp/aleph_tmp/#{Date.today.to_s(:dashed)}-ru-items.xml"
  end


end
