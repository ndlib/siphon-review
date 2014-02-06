

describe ReformattingBook do

  it "has attributes" do
    [:id, :title, :oclc_number, :frbr_group_id, :call_number, :category, :barcode, :status, :nd_holdings, :number_of_loans, :number_of_libraries, :hathi_trust_url, :books_in_print_url, :internet_active_url, :oclc_url, :notes_for_selector, :notes_from_selector, :withdraw, :photodup, :microfilm_nd, :digital_link, :purchase_reprint, :purchase_microfilm, :fund_code, :withdraw_completed, :photodup_completed, :microfilm_nd_completed, :digital_link_completed, :purchase_reprint_completed, :purchase_microfilm_completed].each do | attr |
      expect(ReformattingBook.new.respond_to?(attr)).to be_true
      expect(ReformattingBook.new.respond_to?("#{attr}=")).to be_true
    end
  end

  describe :state_machines do

    it "has state" do
      states = ReformattingBook.state_machines[:status].states.map(&:name)
      expect(states).to eq([:new, :inprocess, :prepared, :decisioned, :complete])
    end


    it "starts in the new state" do
      expect(ReformattingBook.new.status).to eq("new")
    end


    it "new allows you to go to inprocess" do
      b = ReformattingBook.new(status: 'new')
      expect(b.start).to be_true
      expect(b.status).to eq("inprocess")
    end


    it "inprocess allows you to go to prepared" do
      b = ReformattingBook.new(status: 'inprocess')
      expect(b.prepare).to be_true
      expect(b.status).to eq("prepared")
    end


    it "prepared allows you to go to inprocess from prepared" do
      b = ReformattingBook.new(status: 'prepared')
      expect(b.back).to be_true
      expect(b.status).to eq("inprocess")
    end


    it "prepared allows you to go to decisioned" do
      b = ReformattingBook.new(status: 'prepared')
      expect(b.decision).to be_true
      expect(b.status).to eq("decisioned")
    end


    it "decisioned allows you to go to complete" do
      b = ReformattingBook.new(status: 'decisioned')
      expect(b.complete).to be_true
      expect(b.status).to eq("complete")
    end


    it "decisioned allows you to go to prepared from decisioned" do
      b = ReformattingBook.new(status: 'decisioned')
      expect(b.back).to be_true
      expect(b.status).to eq("prepared")
    end


    it "complete allows you to go to decisioned from complete" do
      b = ReformattingBook.new(status: 'complete')
      expect(b.back).to be_true
      expect(b.status).to eq("decisioned")
    end

  end


  describe :search_status do

    before(:each) do
      @new = ReformattingBook.new(title: 'new', status: 'new')
      @new.save!

      @inprocess = ReformattingBook.new(title: 'inprocess', status: 'inprocess')
      @inprocess.save!

      @prepared = ReformattingBook.new(title: 'prepared', status: 'prepared')
      @prepared.save!

      @decisioned = ReformattingBook.new(title: 'decisioned', status: 'decisioned')
      @decisioned.save!

      @complete = ReformattingBook.new(title: 'complete', status: 'complete')
      @complete.save!
    end

    context :by_status do

      it "finds the new items" do
        expect(ReformattingBook.by_status('new')).to eq([@new])
      end


      it "finds the inprocess items" do
        expect(ReformattingBook.by_status('inprocess')).to eq([@inprocess])
      end

      it "finds the prepared items" do
        expect(ReformattingBook.by_status('prepared')).to eq([@prepared])
      end

      it "finds the decisioned items" do
        expect(ReformattingBook.by_status('decisioned')).to eq([@decisioned])
      end

      it "finds the complete items" do
        expect(ReformattingBook.by_status('complete')).to eq([@complete])
      end
    end

    context :books_to_be_microfilmed do

      it "returns the books to be microfilmed" do
        expect(ReformattingBook.books_to_be_microfilmed).to eq([@decisioned])
      end
    end

  end


  describe :by_document_number do

    before(:each) do
      @document = ReformattingBook.new(title: 'new', status: 'new', document_number: 'number')
      @document.save!

      @other = ReformattingBook.new(title: 'inprocess', status: 'inprocess', document_number: 'not_number')
      @other.save!
    end


    it "returns the correct document " do
      expect(ReformattingBook.by_document_number('number')).to eq(@document)
    end
  end


end
