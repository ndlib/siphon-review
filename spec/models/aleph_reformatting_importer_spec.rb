

describe AlephReformattingImporter do

  before(:each) do
    @importer = AlephReformattingImporter.new
  end

  describe :file_name do

    it "returns the path based on the current day " do
      expect(@importer.file_name).to eq("http://alephprod.library.nd.edu/app_tmp/aleph_tmp/#{Date.today.to_s(:dashed)}-ru-items.xml")
    end
  end


  describe :xml_from_source do

  end

end
