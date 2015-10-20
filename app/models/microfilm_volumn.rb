class MicrofilmVolumn < ActiveRecord::Base

  belongs_to :microfilm_reel
  belongs_to :reformatting_book


  def title
    print_title
  end

  def target_number
    (order + 1).to_s.rjust(2, "0")
  end

  def master_negative
    "#{microfilm_reel.name} - #{target_number}"
  end
end
