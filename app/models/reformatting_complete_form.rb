class ReformattingCompleteForm

  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :book

  attribute :withdraw_completed, Boolean
  attribute :photodup_completed, Boolean
  attribute :retain_completed, Boolean
  attribute :no_action_completed, Boolean
  attribute :retain_and_transfer_completed, Boolean
  attribute :digital_completed, Boolean
  attribute :digital_and_paper_output_completed, Boolean
  attribute :microfilm_nd_completed, Boolean
  attribute :digital_link_completed, Boolean
  attribute :purchase_reprint_completed, Boolean
  attribute :purchase_microfilm_completed, Boolean
  attribute :send_to_special_collections_completed, Boolean
  attribute :box_completed, Boolean
  attribute :return_to_shelf_completed, Boolean


  delegate :id, to: :book

  def initialize(book, params = {})
    @book = book

    self.attributes.each_key do |key|
      self.send("#{key}=", book.send(key))
    end

    if params[:reformatting_complete_form]
      self.attributes = params[:reformatting_complete_form]
    end
  end


  def section1
    { partial: 'prepare_info', locals: { book_form: self } }
  end


  def section2
    { partial: 'decision_info', locals: { book_form: self } }
  end


  def section3
    { partial: 'complete_form', locals: { book_form: self } }
  end


  def decision_fields
    [ :digital, :digital_and_paper_output, :withdraw, :retain, :retain_and_transfer, :box, :microfilm_nd, :digital_link, :purchase_reprint, :purchase_microfilm, :return_to_shelf, :send_to_special_collections]
  end


  def send_to_next_step
    if valid?
      persist!
      true
    else
      false
    end
  end


  def send_back_step
    true
  end


  private

    def persist!
      @book.attributes = self.attributes

      if all_actions_completed?
        @book.complete
      end

      @book.save!
    end


    def all_actions_completed?
      decision_fields.each do | field |
        # if the decision field has been selected and the
        if !action_completed_for_field?(field)
          return false
        end
      end

      return true
    end


    def action_completed_for_field?(field)
      if @book.send(field)
        if self.send("#{field}_completed")
          return true
        else
          return false
        end
      else
        return true
      end
    end
end
