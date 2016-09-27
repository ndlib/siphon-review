
describe ReformattingPrepareForm do

  let(:book) do
    instance_double(ReformattingBook,
                    id: 0,
                    nd_holdings: "",
                    number_of_loans: "",
                    number_of_libraries: "",
                    hathi_trust_url: "",
                    amazon_url: "",
                    abe_books_url: "",
                    alibris_url: "",
                    internet_active_url: "",
                    microfilm_only: false,
                    notes_for_selector: ""
    )
  end

  it "has an id" do
    expect(ReformattingPrepareForm.new(book)).to respond_to(:id)
    expect(ReformattingPrepareForm.new(book).id).to eq(book.id)
  end


  it "has section1" do
    book_form = ReformattingPrepareForm.new(book)

    expect(book_form).to respond_to(:section1)
    expect(book_form.section1).to eq( { partial: 'prepare_form', locals: { book_form: book_form }} )
  end


  it "has section2" do
    book_form = ReformattingPrepareForm.new(book)

    expect(book_form).to respond_to(:section2)
    expect(book_form.section2).to eq( { text: "" } )
  end


  it "has section3" do
    book_form = ReformattingPrepareForm.new(book)

    expect(book_form).to respond_to(:section3)
    expect(book_form.section3).to eq( { text: "" } )
  end


  context :validations do
    # none
  end


  context :persistance do
    before(:each) do
      @form = ReformattingPrepareForm.new(book, { reformatting_prepare_form: { books_in_print_url: 'books_in_print_url', internet_active_url: 'internet_active_url', oclc_url: 'oclc_url', notes_for_selector: 'notes_for_selector'} })

      allow(book).to receive(:prepare)
      allow(book).to receive(:attributes=).with(any_args)
      allow(book).to receive(:save!)
    end


    it "sets the parameters from the form " do
      expect(book).to receive(:attributes=)
      @form.send_to_next_step
    end


    it "calls save on the book model" do
      expect(book).to receive(:save!)
      @form.send_to_next_step
    end


    it "prepares the book" do
      expect(book).to receive(:prepare)
      @form.send_to_next_step
    end

  end
end

