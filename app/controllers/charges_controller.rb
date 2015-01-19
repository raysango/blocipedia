class ChargesController < ApplicationController
def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     amount: 2500
   }
 end

  def edit
  end

  def index
  end

  def show
  end
  
  def create
 
   # Creates a Stripe Customer object, for associating
   # with the charge
    @amount = 2500
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )
 
   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: @amount,
     description: "BigMoney Membership - #{current_user.email}",
     currency: 'usd'
   )
    current_user.update(role:"premium", plan_id: "2")
    current_user.save!
    flash[:note] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
   redirect_to edit_user_registration_path(current_user) # or wherever
 
 # Stripe will send back CardErrors, with friendly messages
 # when something goes wrong.
 # This `rescue block` catches and displays those errors.
 rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path
 end
end
