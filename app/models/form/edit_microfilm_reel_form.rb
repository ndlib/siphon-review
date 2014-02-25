class EditMicrofilmReelForm

  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :microfilm_reel

  attribute :volumns, Hash
  attribute :complete, Boolean

  def self.build_from_params(controller)
    controller.params.permit(:edit_microfilm_reel_form).permit(:volumns)
    controller.params.permit(:edit_microfilm_reel_form).permit(:complete)
    controller.params.require(:id)

    reel = MicrofilmReel.find(controller.params[:id])

    self.new(reel, controller.params[:edit_microfilm_reel_form])
  end


  def initialize(reel, params)
    @microfilm_reel = reel

    self.complete = (@microfilm_reel.status == 'closed')
    pass_in_params(params)

  end


  def potential_volumns
    ReformattingBook.books_to_be_microfilmed
  end


  def current_volumns
    @microfilm_reel.microfilm_volumns
  end


  def reel_name
    @microfilm_reel.name
  end


  def add_volumns!
    if valid?
      persist!
      true
    else
      false
    end
  end


  def closed?
    @microfilm_reel.closed?
  end

  private


    def pass_in_params(params)
      if params
        self.attributes = params
      end
    end


    def persist!
      @microfilm_reel.microfilm_volumns.destroy_all

      index = 0
      volumns.each_pair do | book_id, book_title |
        @microfilm_reel.microfilm_volumns.create(reformatting_book_id: book_id, order: index, print_title: book_title)
        index += 1
      end

      if complete.present?
        @microfilm_reel.close
      else
        @microfilm_reel.reopen
      end

      @microfilm_reel.save!
    end
end
