

describe ReformattingForm do
  before(:each) do
    @book = ReformattingBook.new(status: 'new')
    @book.save

    @controller = double(ApplicationController, params: { id: @book.id } )
  end

  context :book do

    it "builds the book from params" do
      expect(ReformattingForm.new(@controller).book.id).to eq(@book.id)
    end

  end


  context :verify_in_process do

    it "converts new items to in process" do
      @book.status = 'new'
      @book.save!

      expect(ReformattingForm.new(@controller).book.status).to eq("inprocess")
    end

    it "does not convert the other statuses" do
      ["inprocess", "prepared", "decisioned", "complete"].each do | status |
        @book.status = status
        @book.save!

        expect(ReformattingForm.new(@controller).book.status).to eq(status)
      end
    end
  end


  context :status_form_factory do

    it "returns the prepare form if the status is inprocess" do
      @book.status = 'inprocess'
      @book.save!

      expect(ReformattingForm.new(@controller).status_form.class).to eq(ReformattingPrepareForm)
    end

    it "returns the decision form if the status is prepared" do
      @book.status = 'prepared'
      @book.save!

      expect(ReformattingForm.new(@controller).status_form.class).to eq(ReformattingDecisionForm)
    end


    it "raises and error if the status is not found" do
      book = double(ReformattingBook, status: 'dsfasdfadsfadsas', start: true, save!: true)
      ReformattingForm.any_instance.stub(:get_book).and_return(book)
      # this will be changed to ReformattingForm::StatusNotFound
      expect { ReformattingForm.new(@controller).status_form }.to raise_error(ReformattingForm::StatusNotFound)
    end
  end
end

