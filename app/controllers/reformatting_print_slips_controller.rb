class ReformattingPrintSlipsController < ApplicationController


  def print
    @print_slips = ReformattingPrintSlips.build_from_params(self)

    render layout: 'print'
  end

end
