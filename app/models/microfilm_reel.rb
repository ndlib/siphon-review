
class MicrofilmReel < ActiveRecord::Base

  # the state_machine gem is no longer maintained and initial values are broken in rails 4.2. This is a work around.
  # see https://github.com/pluginaweek/state_machine/issues/334
  after_initialize :set_initial_status
  def set_initial_status
    self.status ||= :open
  end

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
