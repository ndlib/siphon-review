class DecisionFromValidator < ActiveModel::Validator
  def validate(record)
    res = record.attributes.reject{ | key, value | key == :fund_code }.select { | key, value | !value.nil? && value }

    if res.size == 0
      record.errors.add(:base, 'You must select one of the decision out comes. ')
    end
  end
end


class ReformattingDecisionForm

  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :book

  attribute :withdraw, Boolean
  attribute :digital, Boolean
  attribute :digital_and_paper_output, Boolean
  attribute :no_action, Boolean
  attribute :retain, Boolean
  attribute :retain_and_transfer, Boolean
  attribute :notes_from_selector, String

  delegate :id, to: :book

  validates_with DecisionFromValidator

  def initialize(book, params = {})
    @book = book

    self.attributes.each_key do |key|
      self.send("#{key}=", book.send(key))
    end

    if params[:reformatting_decision_form]
      self.attributes = params[:reformatting_decision_form]
    end
  end


  def section1
    { partial: 'prepare_info', locals: { book_form: self } }
  end


  def section2
    { partial: 'decision_form', locals: { book_form: self } }
  end


  def section3
    { text: "" }
  end


  def send_to_next_step
    if valid?
      persist!
      true
    else
      false
    end
  end


  private

    def persist!
      @book.decision

      @book.attributes = self.attributes
      @book.save!
    end

end
