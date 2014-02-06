class MicrofilmVolumn < ActiveRecord::Base

  belongs_to :microfilm_reel
  belongs_to :reformatting_book


  def title
    print_title
  end

end
