class ReformattingsController < ApplicationController


  def index
    @reformatting_list = ReformattingList.new(self)
  end


  def create
    ReformattingBook.test_book.save!

    redirect_to reformattings_path
  end


  def edit
    @form = ReformattingForm.new(self)
  end


  def update
    @form = ReformattingForm.new(self)

    if params[:goto_previous_step]
      if @form.send_back_step
        flash[:success] = "Moved back to #{@form.book.status}"
        redirect_to edit_reformatting_path(@form.book)
      else
        flash[:error] = "Unable to go back to previous status"
        render :edit
      end
    else
      if @form.send_to_next_step
        flash[:success] = "Saved Step"
        redirect_to edit_reformatting_path(@form.book)
      else
        flash[:error] = "Your form submission has errors in it.  Please correct them and resubmit."
        render :edit
      end
    end

  end

end
