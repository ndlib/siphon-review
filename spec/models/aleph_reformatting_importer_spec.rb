

describe AlephReformattingImporter do

  before(:each) do
    @importer = AlephReformattingImporter.new
  end

  describe :file_name do

    it "returns the path based on the current day " do
      expect(@importer.file_name).to eq("https://alephprod.library.nd.edu/aleph_tmp/#{Date.today.to_s(:dashed)}-ru-items.xml")
    end
  end


  describe :xml_from_source do

  end

end
