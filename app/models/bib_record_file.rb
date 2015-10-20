class BibRecordFile
  attr_reader :sysnumber

  def self.load(sysnumber)
    new(sysnumber).file
  end

  def initialize(sysnumber)
    @sysnumber = sysnumber
  end

  def file
    split_body
  end

  private

  def request_url
    "https://aleph1.library.nd.edu:443"
  end

  def generate_file_path
    "/F/?func=full-mail&doc_library=NDU01&doc_number=#{sysnumber}&format=001"
  end

  def bib_file_url
    Nokogiri::HTML(generate_file_body).xpath('//p[contains(@class, "text3")]/a').first.attributes['href'].value
  end

  def bib_file_body
    @bib_file_url ||= connection.get(bib_file_url).body.
      gsub(/^(.*__________________)/m, "").
      gsub(/([\s]{12})/, "")
  end

  def split_body
    @split_body ||= bib_file_body.split("\r\n\r\n").collect { |row| row.truncate(100) }.join("\r\n\r\n")
  end

  def generate_file_body
    @generate_file_body ||= connection.get(generate_file_path).body
  end

  def connection
    @connection ||= Faraday.new(:url => request_url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end
end
