require 'spec_helper'

describe DiscoveryApi do
  let(:test_search) { "ndu_aleph000188916" }
  let(:test_data) do
    {
      "type" => 'book',
      "display" => {
        "title" => "The once and future king.",
        "creator_contributor" => "T. H. White [Terence Hanbury], 1906-1964.",
        "details" => "",
        "publisher_provider" => "New York, Putnam 1958",
        "availability" => "Available",
        "available_library" => "Notre Dame, Hesburgh Library General Collection (PR 6045 .H676 O5 )",
      },
      "id" => test_search,
      "oclc" => "58010760",
      "primo" => {
        "facets" => {
          "frbrgroupid" => "73181443",
        },
      },
      "holdings" => [{
        "record_id" => test_search,
        "number_of_loans" => "37"
      }]
    }
  end

  before(:each) do
    allow_any_instance_of(DiscoveryApi).to receive(:make_request).with(test_search).and_return(test_data)
  end

  describe :search_by_ids do

    it "searchs by a single id" do
      res = DiscoveryApi.search_by_id(test_search)
      res.title.should == "The once and future king."
    end

  end


  describe "attributes" do

    before(:each) do
      @discovery_api = DiscoveryApi.search_by_id(test_search)
    end

    it "has a type" do
      expect(@discovery_api.type).to eq('book')
    end


    it "has a title" do
      @discovery_api.title.should == "The once and future king."
    end


    it "has the creator_contributor" do
      @discovery_api.creator_contributor.should == "T. H. White [Terence Hanbury], 1906-1964."
    end


    it "has details" do
      @discovery_api.details.should == ""
    end



    it "has publisher_provider" do
      @discovery_api.publisher_provider.should == "New York, Putnam 1958"
    end


    it "has availability" do
      @discovery_api.availability.should == "Available"
    end


    it "has availabile_library" do
      @discovery_api.available_library.should == "Notre Dame, Hesburgh Library General Collection (PR 6045 .H676 O5 )"
    end


    it "has an id " do
      expect(@discovery_api.id).to eq(test_search)
    end


    it "has the oclc number " do
      expect(@discovery_api.oclc_number).to eq("58010760")
    end


    it "has the frbr_group_id  " do
      expect(@discovery_api.frbr_group_id).to eq("73181443")
    end


    it "has the number of loans" do
      expect(@discovery_api.number_of_loans).to eq("37")
    end
  end


  describe :fix_id do
    before(:each) do
      expect_any_instance_of(DiscoveryApi).to receive(:make_request)
    end

    it "adds ndu aleph if it is not there" do
      res = DiscoveryApi.search_by_id("000188916")
      expect(res.id).to eq("ndu_aleph000188916")
    end


    it "justifies if there are no 0s" do
      res = DiscoveryApi.search_by_id("188916")
      expect(res.id).to eq("ndu_aleph000188916")
    end

  end


  describe :truncation do
    before(:each) do
      @discovery_api = DiscoveryApi.search_by_id(test_search)
    end

    it "truncates the publisher_provider" do
      String.any_instance.should_receive(:truncate)
      @discovery_api.publisher_provider
    end


    it "truncates the creator_contributor" do
      String.any_instance.should_receive(:truncate)
      @discovery_api.creator_contributor
    end


    it "truncates the details" do
      String.any_instance.should_receive(:truncate)
      @discovery_api.details
    end
  end
end
