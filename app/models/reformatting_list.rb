
class ReformattingList
  attr_reader :status

  AVAILABLE_STATUSES = ['new', 'inprocess', 'prepared', 'decisioned', 'complete']

  def initialize(controller)
    @controller = controller
    @status = determine_status

    if !AVAILABLE_STATUSES.include?(@status)
      raise "Status passed to reformating is not valid"
    end
  end


  def books
    ReformattingBook.where(status: @status)
  end


  def tab_css_class(tab)
    if tab_active?(tab)
      'active'
    else
      ''
    end
  end

  private

    def tab_active?(tab)
      tab.downcase == @status
    end


    def determine_status
      if !@controller.params[:status]
        'new'
      else
        @controller.params[:status]
      end
    end
end
