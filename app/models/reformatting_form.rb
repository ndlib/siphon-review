
class ReformattingForm

  class StatusNotFound < Exception; end

  attr_accessor :book

  def initialize(controller)
    @controller = controller
    @book = get_book(@controller.params[:id])

    verify_in_process!
  end


  def status_form
    @status_form ||= case @book.status
      when 'inprocess'
        ReformattingPrepareForm.new(@book, @controller.params)
      when 'prepared'
        ReformattingDecisionForm.new(@book, @controller.params)
      when 'decisioned'
        ReformattingCompleteForm.new(@book, @controller.params)
      when 'complete'
        ReformattingCompletedForm.new(@book, @controller.params)
      else
        raise StatusNotFound.new("invalid book status")
      end
  end


  def section1
    status_form.section1
  end


  def section2
    status_form.section2
  end


  def section3
    status_form.section3
  end


  def send_to_next_step
    status_form.send_to_next_step
  end


  def send_back_step
    @book.back
  end


  private

    def get_book(id)
      ReformattingBook.find(id)
    end


    def verify_in_process!
      if @book.start
        @book.save!
      end
    end
end
