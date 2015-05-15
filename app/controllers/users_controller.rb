class UsersController < ApplicationController
  layout "public"
  def show
    @user = User.friendly.find(params[:id])
    @usertime = current_user.stripe_end_date
    @renewdate = Time.at(current_user.stripe_end_date).strftime("%B %d, %Y") if current_user.stripe_end_date.present?
    @machines = Machine.all
    
    if current_user.stripe_subscription_id.present?
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
      if customer.subscriptions.data.first['status'] == "trialing"
        @trial_status = "trialing"
        @trialend = customer.subscriptions.data.first['trial_end']
      end
      if customer.subscriptions.data.first['cancel_at_period_end'] == true
        @trial_ending = true
      end
    end
  end
end
