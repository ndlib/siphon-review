

describe MicrofilmReelList do


  before(:each) do
    @controller = double(ApplicationController, params: {}, current_user: double(User) )
  end


  describe :status do

    it "defaults to open" do
      object = MicrofilmReelList.new(@controller)
      expect(object.status).to eq("open")
    end

    it "allows the availale statuses to be set" do
      MicrofilmReelList::AVAILABLE_STATUSES.each do | status |
        @controller.params[:status] = status
        object = MicrofilmReelList.new(@controller)
        expect(object.status).to eq(status)
      end
    end
  end



  describe :tab_css_class do

    it "returns active if the tab matches the status" do
      @controller.params[:status] = 'open'
      object = MicrofilmReelList.new(@controller)

      expect(object.tab_css_class('open')).to eq('active')
    end

  end
end
