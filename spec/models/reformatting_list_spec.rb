
describe ReformattingList do
  before(:each) do
    @controller = double(ApplicationController, params: {}, current_user: double(User) )
  end


  describe :status do

    it "defaults to new" do
      object = ReformattingList.new(@controller)
      expect(object.status).to eq("new")
    end

    it "allows the availale statuses to be set" do
      ReformattingList::AVAILABLE_STATUSES.each do | status |
        @controller.params[:status] = status
        object = ReformattingList.new(@controller)
        expect(object.status).to eq(status)
      end
    end
  end

  describe :book_list do

    it "all the books in the new status" do
      @controller.params[:status] = 'new'
      object = ReformattingList.new(@controller)
      object.books.each do | b |
        expect(b.status).to eq("new")
      end
    end

    it "returns all the inprocess books" do
      @controller.params[:status] = 'inprocess'
      object = ReformattingList.new(@controller)
      object.books.each do | b |
        expect(b.status).to eq("inprocess")
      end
    end

    it "returns all the prepared books" do
      @controller.params[:status] = 'prepared'
      object = ReformattingList.new(@controller)
      object.books.each do | b |
        expect(b.status).to eq("prepared")
      end
    end

    it "returns all the decisioned books" do
      @controller.params[:status] = 'decisioned'
      object = ReformattingList.new(@controller)
      object.books.each do | b |
        expect(b.status).to eq("decisioned")
      end
    end
  end


  describe :tab_css_class do

    it "returns active if the tab matches the status" do
      @controller.params[:status] = 'inprocess'
      object = ReformattingList.new(@controller)

      expect(object.tab_css_class('inprocess')).to eq('active')
    end

  end


end
