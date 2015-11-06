

class MicrofilmReelList
  attr_reader :status

  AVAILABLE_STATUSES = ['open', 'closed']

  def initialize(controller)
    @controller = controller
    @status = determine_status

    if !AVAILABLE_STATUSES.include?(@status)
      raise "Status passed to microfilm is not valid"
    end
  end


  def reels
    MicrofilmReel.where(status: @status).order(:created_at).collect { | reel | reel.title = reel.title.truncate(100) }
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
        'open'
      else
        @controller.params[:status]
      end
    end


end
