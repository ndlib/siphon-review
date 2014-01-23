
describe ReformattingPrepareForm do


  it "has an id" do
    book = ReformattingBook.test_book('inprocess')
    expect(ReformattingPrepareForm.new(book).respond_to?(:id)).to be_true
    expect(ReformattingPrepareForm.new(book).id).to eq(book.id)
  end


  it "has section1" do
    book = ReformattingBook.test_book('inprocess')
    book_form = ReformattingPrepareForm.new(book)

    expect(book_form.respond_to?(:section1)).to be_true
    expect(book_form.section1).to eq( { partial: 'prepare_form', locals: { book_form: book_form }} )
  end


  it "has section2" do
    book = ReformattingBook.test_book('inprocess')
    book_form = ReformattingPrepareForm.new(book)

    expect(book_form.respond_to?(:section2)).to be_true
    expect(book_form.section2).to eq( { text: "" } )
  end


  it "has section3" do
    book = ReformattingBook.test_book('inprocess')
    book_form = ReformattingPrepareForm.new(book)

    expect(book_form.respond_to?(:section3)).to be_true
    expect(book_form.section3).to eq( { text: "" } )
  end


  context :validations do
    # none
  end


  context :persistance do
    before(:each) do
      @book = ReformattingBook.test_book('inprocess')
      @form = ReformattingPrepareForm.new(@book, { reformatting_prepare_form: { books_in_print_url: 'books_in_print_url', internet_active_url: 'internet_active_url', oclc_url: 'oclc_url', notes_for_selector: 'notes_for_selector'} })
    end


    it "sets the parameters from the form " do
      @form.send_to_next_step
      expect(@form.book.books_in_print_url).to eq('books_in_print_url')
      expect(@form.book.internet_active_url).to eq('internet_active_url')
      expect(@form.book.oclc_url).to eq('oclc_url')
      expect(@form.book.notes_for_selector).to eq('notes_for_selector')
    end


    it "calls save on the book model" do
      @book.should_receive(:save!)
      @form.send_to_next_step
    end


    it "prepares the book" do
      @form.send_to_next_step
      expect(@form.book.status).to eq("prepared")
    end

  end
end

