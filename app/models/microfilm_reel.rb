
class MicrofilmReel < ActiveRecord::Base

  has_many :microfilm_volumns, -> { order(:order).includes(:reformatting_book) }


  state_machine :status, :initial => :open do

    event :close do
      transition [:open] => :closed
    end


    event :reopen do
      transition [:closed] => :open
    end


    state :open
    state :closed
  end

  def initialize(attrs = {})
    self.attributes= attrs

    # this is required for the state_machine gem do not forget again and remove
    super()
  end


end
