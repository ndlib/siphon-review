

class MicrofilmPrintSlipsController < ApplicationController


  def show
    @reel = MicrofilmReel.find(params[:id])

    render :layout => 'print'
  end

end
