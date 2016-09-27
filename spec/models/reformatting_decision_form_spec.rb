

describe ReformattingDecisionForm do
  let(:book) do
    instance_double(ReformattingBook,
                    id: 0,
                    withdraw: false,
                    digital: false,
                    digital_and_paper_output: false,
                    no_action: false,
                    retain: false,
                    retain_and_transfer: false,
                    notes_from_selector: "",
    )
  end

  it "has an id" do
    expect(ReformattingDecisionForm.new(book)).to respond_to(:id)
    expect(ReformattingDecisionForm.new(book).id).to eq(book.id)
  end


  it "has section1" do
    book_form = ReformattingDecisionForm.new(book)

    expect(book_form).to respond_to(:section1)
    expect(book_form.section1).to eq( { partial: 'prepare_info', locals: { book_form: book_form }} )
  end


  it "has section2" do
    book_form = ReformattingDecisionForm.new(book)

    expect(book_form).to respond_to(:section2)
    expect(book_form.section2).to eq( { partial: 'decision_form', locals: { book_form: book_form }} )
  end


  it "has section3" do
    book_form = ReformattingDecisionForm.new(book)

    expect(book_form).to respond_to(:section3)
    expect(book_form.section3).to eq( { text: "" } )
  end


  context :validations do
    # one decision must be selected

    # fund code validations
  end


  context :persistance do
    before(:each) do
      @form = ReformattingDecisionForm.new(book, { reformatting_decision_form: { withdraw: '1', photodup: '1', fund_code: 'fundcode', microfilm_nd: '1', digital_link: '1', purchase_reprint: '1', purchase_microfilm: '1' }})
      allow(book).to receive(:decision)
      allow(book).to receive(:attributes=).with(any_args)
      allow(book).to receive(:save!)
    end


    it "sets the values in the book" do
      expect(book).to receive(:attributes=)
      @form.send_to_next_step
    end


    it "calls save on the book model" do
      book.should_receive(:save!)
      @form.send_to_next_step
    end


    it "decisions the book" do
      expect(book).to receive(:decision)
      @form.send_to_next_step
    end

    it "requires the fund code if purchase reprint "


    it "requires the fund code if purchase microfilm "

  end
end
