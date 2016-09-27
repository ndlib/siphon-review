require "spec_helper"

RSpec.describe SynchronizeBookWithCatalog do

  before(:each) do
    @book = double(ReformattingBook, document_number: '23423432', 'oclc_number=' => true, 'frbr_group_id=' => true, save!: true, 'number_of_loans=' => true)

    @discovery_record = instance_double(DiscoveryApi, oclc_number: 'oclc', frbr_group_id: 'frbr', number_of_loans: '5', title: 'title', creator_contributor: 'creator', publisher_provider: 'publisher')
    DiscoveryApi.stub(:search_by_id).and_return(@discovery_record)

    allow(@discovery_record).to receive(:check_record)

    allow(@book).to receive('oclc_number=').with(@discovery_record.oclc_number)
    allow(@book).to receive('frbr_group_id=').with(@discovery_record.frbr_group_id)
    allow(@book).to receive('number_of_loans=').with(@discovery_record.number_of_loans)
    allow(@book).to receive('creator_contributor=').with(@discovery_record.creator_contributor)
    allow(@book).to receive('publisher=').with(@discovery_record.publisher_provider)
    allow(@book).to receive(:save!)
  end


  it "updates the record with the oclc number" do
    expect(@book).to receive('oclc_number=').with(@discovery_record.oclc_number)
    SynchronizeBookWithCatalog.new(@book).synchronize!
  end


  it "updates the record with frbr_group_id " do
    expect(@book).to receive('frbr_group_id=').with(@discovery_record.frbr_group_id)
    SynchronizeBookWithCatalog.new(@book).synchronize!
  end


  it "updates the record with the number of loans " do
    expect(@book).to receive('number_of_loans=').with(@discovery_record.number_of_loans)
    SynchronizeBookWithCatalog.new(@book).synchronize!
  end


  it "updates the record with the creator_contributor " do
    expect(@book).to receive('creator_contributor=').with(@discovery_record.creator_contributor)
    SynchronizeBookWithCatalog.new(@book).synchronize!
  end


  it "updates the record with the publisher " do
    expect(@book).to receive('publisher=').with(@discovery_record.publisher_provider)
    SynchronizeBookWithCatalog.new(@book).synchronize!
  end


  it "saves the record" do
    expect(@book).to receive(:save!)
    SynchronizeBookWithCatalog.new(@book).synchronize!
  end

end
