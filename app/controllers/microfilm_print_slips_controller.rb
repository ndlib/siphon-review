class MicrofilmPrintSlipsController < ApplicationController
  def show
    @reel = MicrofilmReel.find(params[:id])

    @landscape = true
    render :layout => 'print'
  end

  def record_targets
    @reel = MicrofilmReel.find(params[:id])
    render :layout => 'print'
  end
end
