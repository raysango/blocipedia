class UsersController < ApplicationController
   before_action :authenticate_user!
 
   def update
     if current_user.update_attributes(user_params)
       flash[:notice] = "User information updated"
       redirect_to edit_user_registration_path
     else
       flash[:error] = "Invalid user information"
       redirect_to edit_user_registration_path
     end
   end
  
  def cancel_plan
    @user = current_user
    @wikis = @user.wikis
    @user.update(role:"standard")
    @wikis.each do |wiki|
      if wiki.private?
        wiki.update(private: "false")
      end
    end
    redirect_to :back
  end
 
   private
 
   def user_params
     params.require(:user).permit(:name, :role, :plan_id)
   end
 end