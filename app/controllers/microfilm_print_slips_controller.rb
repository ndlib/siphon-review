

class MicrofilmPrintSlipsController < ApplicationController


  def show
    @reel = MicrofilmReel.find(params[:id])

    @landscape = true
    render :layout => 'print'
  end

end
