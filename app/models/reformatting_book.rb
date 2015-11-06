class ReformattingBook < ActiveRecord::Base

  store :data, accessors: [ :publisher, :creator_contributor, :oclc_number, :frbr_group_id, :nd_holdings, :number_of_loans, :number_of_libraries, :hathi_trust_url, :books_in_print_url, :internet_active_url, :oclc_url, :amazon_url, :abe_books_url, :alibris_url, :microfilm_only, :notes_for_selector, :notes_from_selector, :withdraw, :photodup, :microfilm_nd, :digital_link, :purchase_reprint, :purchase_microfilm, :return_to_shelf, :box, :send_to_special_collections, :fund_code, :return_to_shelf_completed,:send_to_special_collections_completed, :box_completed, :withdraw_completed, :photodup_completed, :microfilm_nd_completed, :digital_link_completed, :purchase_reprint_completed, :purchase_microfilm_completed, :aleph_description, :digital, :digital_and_paper_output, :digital_completed, :digital_and_paper_output_completed ]


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

  def self.by_status(status)
    self.where(status: status)
  end

  def self.by_document_number(number)
    self.where(document_number: number).first
  end

  def self.by_unique_id(number)
    self.where(unique_id: number).first
  end

  def self.books_to_be_microfilmed
    self.by_status('decisioned').order(:title)
  end

  def formatted_document_number
    document_number.rjust(9, "0")
  end
end
