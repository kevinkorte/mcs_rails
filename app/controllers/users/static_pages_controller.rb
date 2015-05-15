class Users::StaticPagesController < ApplicationController
  layout "public"
  before_action :authenticate_user!
  def settings
    customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    @current_plan = current_user.plan.name
    @user_email = current_user.email
    @last_sign_in = current_user.last_sign_in_at
    @billing_date = customer.subscriptions.data.first.current_period_end #returns epoch time
    @plan_price_cents = customer.subscriptions.data.first.plan.amount #returns integer in cents
    @plan_price = (@plan_price_cents / 100)
    @plan_status = customer.subscriptions.data.first.status #returns string
    
    @cancel_at_period_end = customer.subscriptions.data.first.cancel_at_period_end #returns boolean
    @canceled_at = customer.subscriptions.data.first.canceled_at #returns epoch time
    @plan_end_date = customer.subscriptions.data.first.current_period_end #returns epoch time
    
    @trial_end_date = customer.subscriptions.data.first.trial_end #returns epoch time
    
    #Work with Stripe API and cards
    card = Stripe::Customer.retrieve(current_user.stripe_customer_id).sources.all(:limit => 1, :object => "card")
    
    if card.data.present?
      @card_type = card.data.first.brand
      @card_last_4 = card.data.first.last4
    end
    
  end
end
