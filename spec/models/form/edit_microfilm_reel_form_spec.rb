

describe EditMicrofilmReelForm do


  describe :edit_action do


    before(:each) do
      @reel = double(MicrofilmReel, name: 'name', microfilm_volumns: [], status: 'open')
      MicrofilmReel.stub(:find).and_return(@reel)

      @controller = double(ApplicationController, params: ActionController::Parameters.new(id: 1) )
    end


    it "builds successfully from the new action" do
      expect { EditMicrofilmReelForm.build_from_params(@controller) }.to_not raise_error
    end


    it "adds a microfilm_reel " do
      expect(EditMicrofilmReelForm.build_from_params(@controller).microfilm_reel.name).to eq(@reel.name)
    end


    it "sets completed to be false if the mircofilm reel is open" do
      expect(EditMicrofilmReelForm.build_from_params(@controller).complete).to be_falsey
    end


    it "sets completed to be true if the mircofilm reel is closed" do
      @reel.stub(:status).and_return('closed')
      expect(EditMicrofilmReelForm.build_from_params(@controller).complete).to be_truthy
    end
  end


  describe :update_action do
    before(:each) do
      @reel = double(MicrofilmReel, name: 'name', microfilm_volumns: [], status: 'open')
      @input_volumns = { 1 => 'name1' , 2 => 'name2', 3 => 'name3'  }
      MicrofilmReel.stub(:find).with(1).and_return(@reel)

      @controller = double(ApplicationController, params: ActionController::Parameters.new(id: 1, edit_microfilm_reel_form: { volumns: @input_volumns, complete: true } ) )
    end


    it "builds successfully from the new action" do
      expect { EditMicrofilmReelForm.build_from_params(@controller) }.to_not raise_error
    end


    it "adds a microfilm_reel " do
      expect(EditMicrofilmReelForm.build_from_params(@controller).microfilm_reel.name).to eq(@reel.name)
    end


    it "passes the ids to of the new volumns " do
      expect(EditMicrofilmReelForm.build_from_params(@controller).volumns).to eq(@input_volumns)
    end


    it "passes in if the item is complete or not" do
      expect(EditMicrofilmReelForm.build_from_params(@controller).complete).to eq(true)
    end
  end


  describe :potential_volumns do
    before(:each) do
      reel = double(MicrofilmReel, name: 'name', microfilm_volumns: [], status: 'open')
      @form = EditMicrofilmReelForm.new(reel, {})
    end


    it "calls the correct potential volumn method" do
      expect(ReformattingBook).to receive(:books_to_be_microfilmed)
      @form.potential_volumns
    end
  end


  describe :add_volumns do
    before(:each) do
      @reel = MicrofilmReel.new(name: 'name')
      @reel.save!
    end

    context :complete do
      before(:each) do
        @form = EditMicrofilmReelForm.new(@reel, { volumns: { 1 => 'name1' , 3 => 'name2' }, complete: true } )
      end


      it "completes the reel if it is complete" do
        @form.add_volumns!
        expect(@form.microfilm_reel.status).to eq("closed")
      end

    end

    context :incomplete do

      before(:each) do
        @form = EditMicrofilmReelForm.new(@reel, { volumns: { 1 => 'name1' , 3 => 'name2' }, complete: false } )
      end


      it "does not complete the reel if it is not complete" do
        @form.add_volumns!
        expect(@form.microfilm_reel.status).to eq("open")
      end

    end


    context :saving do
      before(:each) do
        @form = EditMicrofilmReelForm.new(@reel, { volumns: { 1 => 'name1' , 3 => 'name2' }, complete: true } )
        @form.add_volumns!
      end


      it "creates volumns in the order they are passed in" do
        expect(@form.microfilm_reel.microfilm_volumns.size).to eq(2)
        expect(@form.microfilm_reel.microfilm_volumns.first.reformatting_book_id).to eq(1)
        expect(@form.microfilm_reel.microfilm_volumns.first.order).to eq(0)
        expect(@form.microfilm_reel.microfilm_volumns.last.reformatting_book_id).to eq(3)
        expect(@form.microfilm_reel.microfilm_volumns.last.order).to eq(1)
      end
    end


    context :changes_existing_volumns do

      before(:each) do
        @reel.microfilm_volumns.create(:reformatting_book_id => 2)

        @form = EditMicrofilmReelForm.new(@reel, { volumns: [ 1 , 3 ], complete: true } )
      end


      it "replaces volumns in the order they are passed in" do
        @form.add_volumns!

        expect(@form.microfilm_reel.microfilm_volumns.size).to eq(2)
        expect(@form.microfilm_reel.microfilm_volumns.first.reformatting_book_id).to eq(1)
        expect(@form.microfilm_reel.microfilm_volumns.first.order).to eq(0)
        expect(@form.microfilm_reel.microfilm_volumns.last.reformatting_book_id).to eq(3)
        expect(@form.microfilm_reel.microfilm_volumns.last.order).to eq(1)
      end
    end
  end

end
