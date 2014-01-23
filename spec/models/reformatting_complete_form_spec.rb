
describe ReformattingCompleteForm do


  it "has an id" do
    book = ReformattingBook.test_book('decisioned')
    expect(ReformattingCompleteForm.new(book).respond_to?(:id)).to be_true
    expect(ReformattingCompleteForm.new(book).id).to eq(book.id)
  end


  it "has section1" do
    book = ReformattingBook.test_book('decisioned')
    book_form = ReformattingCompleteForm.new(book)

    expect(book_form.respond_to?(:section1)).to be_true
    expect(book_form.section1).to eq( { partial: 'prepare_info', locals: { book_form: book_form }} )
  end


  it "has section2" do
    book = ReformattingBook.test_book('decisioned')
    book_form = ReformattingCompleteForm.new(book)

    expect(book_form.respond_to?(:section2)).to be_true
    expect(book_form.section2).to eq( { partial: 'decision_info', locals: { book_form: book_form }} )
  end


  it "has section3" do
    book = ReformattingBook.test_book('decisioned')
    book_form = ReformattingCompleteForm.new(book)

    expect(book_form.respond_to?(:section3)).to be_true
    expect(book_form.section3).to eq( { partial: 'complete_form', locals: { book_form: book_form }} )
  end



  context :validations do
    # none
  end

  context :persistance do
    before(:each) do
      @book = ReformattingBook.test_book('decisioned')
      @book.withdraw = true
      @book.photodup = true
      @book.save!
    end


    it "changes the state only when all the actions have been taken." do
      book_form = ReformattingCompleteForm.new(@book, { reformatting_complete_form: { withdraw_completed: 1, photodup_completed: 1 }})
      book_form.send_to_next_step
      expect(book_form.book.status).to eq("complete")
    end


    it "does not change the state if there is an unchecked action" do
      book_form = ReformattingCompleteForm.new(@book, { reformatting_complete_form: { withdraw_completed: 1 }})
      book_form.send_to_next_step
      expect(book_form.book.status).to eq("decisioned")
    end

  end
end
