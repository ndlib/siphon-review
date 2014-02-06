
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


end
