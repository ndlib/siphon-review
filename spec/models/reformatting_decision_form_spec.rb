

describe ReformattingDecisionForm do


  it "has an id" do
    book = ReformattingBook.test_book('prepared')

    expect(ReformattingDecisionForm.new(book).respond_to?(:id)).to be_true
    expect(ReformattingDecisionForm.new(book).id).to eq(book.id)
  end


  it "has section1" do
    book = ReformattingBook.test_book('prepared')
    book_form = ReformattingDecisionForm.new(book)

    expect(book_form.respond_to?(:section1)).to be_true
    expect(book_form.section1).to eq( { partial: 'prepare_info', locals: { book_form: book_form }} )
  end


  it "has section2" do
    book = ReformattingBook.test_book('prepared')
    book_form = ReformattingDecisionForm.new(book)

    expect(book_form.respond_to?(:section2)).to be_true
    expect(book_form.section2).to eq( { partial: 'decision_form', locals: { book_form: book_form }} )
  end


  it "has section3" do
    book = ReformattingBook.test_book('prepared')
    book_form = ReformattingDecisionForm.new(book)

    expect(book_form.respond_to?(:section3)).to be_true
    expect(book_form.section3).to eq( { text: "" } )
  end


  context :validations do
    # one decision must be selected

    # fund code validations
  end


  context :persistance do
    before(:each) do
      @book = ReformattingBook.test_book('prepared')
      @form = ReformattingDecisionForm.new(@book, { reformatting_decision_form: { withdraw: '1', photodup: '1', fund_code: 'fundcode', microfilm_nd: '1', digital_link: '1', purchase_reprint: '1', purchase_microfilm: '1' }})
    end


    it "sets the values in the book" do
      @form.send_to_next_step
      expect(@form.book.withdraw).to be_true
      expect(@form.book.photodup).to be_true
      expect(@form.book.microfilm_nd).to be_true
      expect(@form.book.digital_link).to be_true
      expect(@form.book.purchase_reprint).to be_true
      expect(@form.book.purchase_microfilm).to be_true
      expect(@form.book.fund_code).to eq("fundcode")
    end


    it "calls save on the book model" do
      @book.should_receive(:save!)
      @form.send_to_next_step
    end


    it "decisions the book" do
      @form.send_to_next_step
      expect(@form.book.status).to eq("decisioned")
    end


    it "requires one decision to be checked" do
      @form = ReformattingDecisionForm.new(@book, { reformatting_decision_form: {  } })
      expect(@form.valid?).to be_false
    end


    it "requires the fund code if purchase reprint "


    it "requires the fund code if purchase microfilm "

  end
end
