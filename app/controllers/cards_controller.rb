class CardsController < ApplicationController
  
  def create
    cu = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    cu.source = params[:stripeToken]
    cu.save
    redirect_to :back
  end
  
end
