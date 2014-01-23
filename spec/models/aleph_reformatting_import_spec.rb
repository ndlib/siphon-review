

describe AlephReformattingImport do
  before(:each) do
    @import_data =     { :title => 'title', :document_number => 'document_number', :call_number => 'call number', :barcode => 'barcode' }

    SynchronizeBookWithCatalog.any_instance.stub(:synchronize!).and_return(true)
  end


  describe :new_record do

    it "Creates a new record if the item does not already exist" do
      AlephReformattingImport.new(@import_data).import!
      expect(ReformattingBook.where(document_number: 'document_number').size).to eq(1)
    end


    it "returns true when a new item is created" do
      expect(AlephReformattingImport.new(@import_data).import!).to be_true
    end


    it "stores the new record as part of the class" do
      import = AlephReformattingImport.new(@import_data)
      import.import!

      expect(import.import_record.document_number).to eq("document_number")
    end


    it "calls synchronize on SynchronizeBookWithCatalog " do
      SynchronizeBookWithCatalog.any_instance.should_receive(:synchronize!)

      AlephReformattingImport.new(@import_data).import!
    end
  end

  describe :existing_record do
    before(:each) do
      ReformattingBook.stub(:where).and_return([double(ReformattingBook, id: 1, document_number: 'already_imported')])
    end


    it "does not create a new item if the item already exists" do
      ReformattingBook.any_instance.should_not_receive(:save!)
      AlephReformattingImport.new(@import_data).import!
    end


    it "returns false if the import! is not set" do
      expect(AlephReformattingImport.new(@import_data).import!).to be_false
    end

    it "stores the found record in the import object" do
      import = AlephReformattingImport.new(@import_data)
      import.import!
      expect(import.import_record.document_number).to eq("already_imported")
    end


  end

end
