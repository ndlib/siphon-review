

class ReformattingPrintSlips

  attr_accessor :books

  def self.build_from_params(controller)
    items = ReformattingBook.find(controller.params[:ids].split(","))

    self.new(items)
  end


  def initialize(reformattings_to_print)
    @books = reformattings_to_print
  end


end
