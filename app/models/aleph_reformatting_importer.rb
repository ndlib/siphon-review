require 'net/http'
require 'uri'
require 'nokogiri'


class AlephReformattingImporter

  def import!
    begin
      xml = xml_from_source
      parse_xml(xml).each do | record |
        parse_attributes(record).each do |item|
          AlephReformattingImport.new(item).import!
        end
      end
    rescue Exception => e
      # log error
      puts "error"
      raise e
    end
  end

  def fix_records!
      xml = xml_from_source
      parse_xml(xml).each do | record |
        parse_new_attributes(record).each do | document_number, conversion |
          if book = ReformattingBook.by_document_number(document_number)
            book.unique_id = conversion
            book.save!
          end
        end
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
    title = record.at('z13-title').text.strip
    document_number = record.at('z13-doc-number').text.strip

    items = []
    record.xpath('item').each do | item |
      ret = {}
      ret[:title] = title
      ret[:document_number] = document_number
      ret[:call_number] = item.at('z30-call-no').text
      ret[:barcode] = item.at('z30-barcode').text
      ret[:unique_id] =  "#{document_number}-#{item.at('z30-item-sequence').text.strip}"
      ret[:aleph_description] = item.at('z30-description').text.strip

      items << ret
    end

    items
  end


  def parse_new_attributes(record)
    doc_number = record.at('z13-doc-number').text
    ret = {}

    item = record.at('item')
    ret[doc_number] = "#{doc_number}-#{item.at('z30-item-sequence').text.strip}"


    ret
  end


  def file_name
    "https://alephprod.library.nd.edu/aleph_tmp/#{Date.today.to_s(:dashed)}-ru-items.xml"
  end


end
