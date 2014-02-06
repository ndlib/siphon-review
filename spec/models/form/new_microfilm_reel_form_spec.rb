

describe NewMicrofilmReelForm do


  describe :new_action do

    before(:each) do
      @controller = double(ApplicationController, params: ActionController::Parameters.new )
    end

    it "builds successfully from the new action" do
      expect { NewMicrofilmReelForm.build_from_params(@controller) }.to_not raise_error
    end
  end


  describe :create_action do

    before(:each) do
      @controller = double(ApplicationController, params: ActionController::Parameters.new(microfilm_reel: { name: 'name' }) )
    end


    it "builds successfully from the create action" do
      expect { NewMicrofilmReelForm.build_from_params(@controller) }.to_not raise_error
    end


    it "sets the name value from the params" do
      expect(NewMicrofilmReelForm.build_from_params(@controller).name).to eq("name")
    end

  end


  describe :create do
    before(:each) do
      @new_reel = NewMicrofilmReelForm.new({ name: 'name' })
    end

    it "saves a new microfilm record" do
      expect(@new_reel.send(:microfilm_reel)).to receive(:save)
      @new_reel.create!
    end


    it "presets the reel to be status open" do
      @new_reel.create!
      expect(@new_reel.send(:microfilm_reel).status).to eq("open")
    end


    it "sets the name of the reeel to be the one passed in" do
      @new_reel.create!
      expect(@new_reel.send(:microfilm_reel).name).to eq("name")
    end

  end


end
