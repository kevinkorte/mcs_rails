class Users::RegistrationsController < Devise::RegistrationsController
  layout "public"
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
   super do
    customer = Stripe::Customer.create(
      :email => params[:user][:email],
      #:source  => params[:stripeToken],
      :plan => 'free'
    )
    @user =User.find_by_email(params[:user][:email])
    @user.stripe_customer_id = customer.id
    @plan = Plan.find_by(:stripe_plan_id => customer.subscriptions.data.first['plan'].id)
    @user.plan_id = @plan.id
    @user.stripe_end_date = customer.subscriptions.data.first.current_period_end
    @user.stripe_subscription_id = customer.subscriptions.data.first.id
   end
    
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
