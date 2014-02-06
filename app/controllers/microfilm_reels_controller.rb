class MicrofilmReelsController < ApplicationController

  def index
    MicrofilmReel
    @list = MicrofilmReelList.new(self)
  end


  def new
    @reel = NewMicrofilmReelForm.build_from_params(self)
  end


  def create
    @reel = NewMicrofilmReelForm.build_from_params(self)

    if @reel.create!()
      flash[:notice] = "Microfilm Reel Created"
      redirect_to edit_microfilm_reel_path(@reel.microfilm_reel)
    else
      flash[:error] = "There has been an error saving the reel.  Please review the form and try again."
    end
  end


  def edit
    @reel = EditMicrofilmReelForm.build_from_params(self)
  end


  def update
    @reel = EditMicrofilmReelForm.build_from_params(self)

    if @reel.add_volumns!()
      flash[:notice] = "Microfilm Reel Saved"
      redirect_to microfilm_reels_path()
    else
      flash[:error] = "There has been an error saving the reel.  Please review the form and try again."
    end

  end



end
