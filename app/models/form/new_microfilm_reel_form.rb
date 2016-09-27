

class NewMicrofilmReelForm

  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :name, String

  validates :name, presence: true

  def self.build_from_params(controller)
    controller.params.permit(:microfilm_reel).permit(:name)

    self.new(controller.params[:microfilm_reel])
  end


  def initialize(params = {})
    pass_in_params(params)
  end


  def create!
    if valid?
      microfilm_reel.status ||= 'open'
      return microfilm_reel.save
    else
      false
    end
  end


  def microfilm_reel
    @microfilm_reel ||= MicrofilmReel.new(attributes)
  end

  private





    def pass_in_params(params)
      if params
        self.attributes = params
      end
    end

end
