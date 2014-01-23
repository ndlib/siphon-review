class ReformattingBook < ActiveRecord::Base

  store :data, accessors: [ :oclc_number, :frbr_group_id, :nd_holdings, :number_of_loans, :number_of_libraries, :hathi_trust_url, :books_in_print_url, :internet_active_url, :oclc_url, :notes_for_selector, :notes_from_selector, :withdraw, :photodup, :microfilm_nd, :digital_link, :purchase_reprint, :purchase_microfilm, :fund_code, :withdraw_completed, :photodup_completed, :microfilm_nd_completed, :digital_link_completed, :purchase_reprint_completed, :purchase_microfilm_completed ]


  state_machine :status, :initial => :new do

    event :start do
      transition [:new] => :inprocess
    end

    event :prepare do
      transition [:inprocess] => :prepared
    end

    event :decision do
      transition [:prepared] => :decisioned
    end

    event :complete do
      transition [:decisioned] => :complete
    end

    event :back do
      transition :complete => :decisioned, :decisioned => :prepared, :prepared => :inprocess
    end

    state :new
    state :inprocess
    state :prepared
    state :decisioned
    state :complete
  end


end
