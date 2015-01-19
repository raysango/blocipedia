class PlansController < ApplicationController
  def new
  end

  def edit
  end

  def show
  end
  
  def delete
    @user = current_user
    @plan = @user.plan_id
    if @plan.delete
      @user.update(role:"standard")
      fash[:notice]= "Your plan has been updated"
      redirect_to :back
    else
      flash[:error] = "There was an error updating your plan, Please try again"
    end
  end
end
