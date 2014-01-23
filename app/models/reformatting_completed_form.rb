class ReformattingCompletedForm

  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :book

  attribute :withdraw_completed, Boolean
  attribute :photodup_completed, Boolean
  attribute :microfilm_nd_completed, Boolean
  attribute :digital_link_completed, Boolean
  attribute :purchase_reprint_completed, Boolean
  attribute :purchase_microfilm_completed, Boolean

  delegate :id, to: :book

  def initialize(book, params = {})
    @book = book

    self.attributes.each_key do |key|
      self.send("#{key}=", book.send(key))
    end

    if params[:reformatting_complete_form]
      self.attributes = params[:reformatting_decision_form]
    end
  end


  def section1
    { partial: 'prepare_info', locals: { book_form: self } }
  end


  def section2
    { partial: 'decision_info', locals: { book_form: self } }
  end


  def section3
    { partial: 'complete_info', locals: { book_form: self } }
  end


  def decision_fields
    [:withdraw_completed, :photodup_completed, :microfilm_nd_completed, :digital_link_completed, :purchase_reprint_completed, :purchase_microfilm_completed ]
  end


  def send_to_next_step
    true
  end


  private

end
