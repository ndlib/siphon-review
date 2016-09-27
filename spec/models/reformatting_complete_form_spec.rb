
describe ReformattingCompleteForm do

  let(:book) do
    instance_double(ReformattingBook,
                    id: 0,
                    withdraw_completed: false,
                    photodup_completed: false,
                    retain_completed: false,
                    no_action_completed: false,
                    retain_and_transfer_completed: false,
                    digital_completed: false,
                    digital_and_paper_output_completed: false,
                    microfilm_nd_completed: false,
                    digital_link_completed: false,
                    purchase_reprint_completed: false,
                    purchase_microfilm_completed: false,
                    send_to_special_collections_completed: false,
                    box_completed: false,
                    return_to_shelf_completed: false,
                    withdraw: false,
                    photodup: false,
                    retain: false,
                    no_action: false,
                    retain_and_transfer: false,
                    digital: false,
                    digital_and_paper_output: false,
                    microfilm_nd: false,
                    digital_link: false,
                    purchase_reprint: false,
                    purchase_microfilm: false,
                    send_to_special_collections: false,
                    box: false,
                    return_to_shelf: false
    )
  end

  it "has an id" do
    expect(ReformattingCompleteForm.new(book)).to respond_to(:id)
    expect(ReformattingCompleteForm.new(book).id).to eq(book.id)
  end


  it "has section1" do
    book_form = ReformattingCompleteForm.new(book)

    expect(book_form).to respond_to(:section1)
    expect(book_form.section1).to eq( { partial: 'prepare_info', locals: { book_form: book_form }} )
  end


  it "has section2" do
    book_form = ReformattingCompleteForm.new(book)

    expect(book_form).to respond_to(:section2)
    expect(book_form.section2).to eq( { partial: 'decision_info', locals: { book_form: book_form }} )
  end


  it "has section3" do
    book_form = ReformattingCompleteForm.new(book)

    expect(book_form).to respond_to(:section3)
    expect(book_form.section3).to eq( { partial: 'complete_form', locals: { book_form: book_form }} )
  end



  context :validations do
    # none
  end

  context :persistance do
    before(:each) do
      allow(book).to receive(:withdraw).and_return(true)
      allow(book).to receive(:photodup).and_return(true)

      allow(book).to receive(:attributes=).with(any_args)
      allow(book).to receive(:save!)
      allow(book).to receive(:complete)
    end


    it "changes the state only when all the actions have been taken." do
      book_form = ReformattingCompleteForm.new(book, { reformatting_complete_form: { withdraw_completed: 1, photodup_completed: 1 }})
      expect(book_form.book).to receive(:complete)
      book_form.send_to_next_step
    end


    it "does not change the state if there is an unchecked action" do
      book_form = ReformattingCompleteForm.new(book, { reformatting_complete_form: { withdraw_completed: 1 }})
      expect(book_form.book).to receive(:complete)
      book_form.send_to_next_step
    end

  end
end
