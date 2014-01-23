
class ReformattingPrepareForm
  include RailsHelpers

  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :book

  attribute :books_in_print_url, String
  attribute :internet_active_url, String
  attribute :oclc_url, String
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
