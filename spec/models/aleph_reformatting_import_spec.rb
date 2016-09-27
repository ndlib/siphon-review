
RSpec.describe AlephReformattingImport do
  before(:each) do
    @import_data = { :unique_id => 0, :title => 'title', :document_number => 'document_number', :call_number => 'call number', :barcode => 'barcode' }

    SynchronizeBookWithCatalog.any_instance.stub(:synchronize).and_return(true)
    ReformattingBook.any_instance.stub(:save!).and_return(true)
  end

  subject { AlephReformattingImport.new(@import_data).import! }

  describe :new_record do
    before(:each) do
      expect(ReformattingBook).to receive(:by_unique_id).with(0).and_return(nil)
    end

    it "Creates a new record if the item does not already exist" do
      expect_any_instance_of(AlephReformattingImport).to receive(:import_item!)
      subject
    end


    it "returns true when a new item is created" do
      expect(subject).to be_truthy
    end


    it "stores the new record as part of the class" do
      import = AlephReformattingImport.new(@import_data)
      import.import!

      expect(import.import_record.document_number).to eq("document_number")
    end


    it "calls synchronize on SynchronizeBookWithCatalog " do
      SynchronizeBookWithCatalog.any_instance.should_receive(:synchronize)

      subject
    end
  end

  describe :existing_record do
    before(:each) do
      book = double(ReformattingBook, id: 1, document_number: 'already_imported')
      allow(book).to receive(:attributes=).with(any_args)
      allow(book).to receive(:save!)

      expect(ReformattingBook).to receive(:by_unique_id)
        .with(0).and_return(book)
    end

    it "updates existing item if the item already exists" do
      expect_any_instance_of(AlephReformattingImport).to receive(:update_item!)
      subject
    end


    it "returns false if the import! is not set" do
      expect(subject).to be_falsey
    end

    it "stores the found record in the import object" do
      import = AlephReformattingImport.new(@import_data)
      import.import!
      expect(import.import_record.document_number).to eq("already_imported")
    end


  end

end
