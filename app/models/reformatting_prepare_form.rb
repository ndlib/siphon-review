
class ReformattingPrepareForm
  include RailsHelpers

  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :book

  attribute :nd_holdings, String
  attribute :number_of_loans, String
  attribute :number_of_libraries, String
  attribute :hathi_trust_url, String
  attribute :amazon_url, String
  attribute :abe_books_url, String
  attribute :alibris_url, String
  attribute :internet_active_url, String
  attribute :microfilm_only, Boolean
  attribute :notes_for_selector, String

  delegate :id, to: :book

  def initialize(book, params = {})
    @book = book

    self.attributes.each_key do |key|
      self.send("#{key}=", book.send(key))
    end

    if params[:reformatting_prepare_form]
      self.attributes = params[:reformatting_prepare_form]
    end
  end


  def send_to_next_step
    if valid?
      persist
      return true
    else
      return false
    end
  end


  def section1
    { partial: 'prepare_form', locals: { book_form: self } }
  end


  def section2
    { text: "" }
  end


  def section3
    { text: "" }
  end



  private

    def persist
      @book.prepare
      @book.attributes = self.attributes
      @book.save!
    end


end
