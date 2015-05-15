class SubscriptionsController < ApplicationController
  protect_from_forgery except: :webhook
  
  #require "json"
  
  def new
  end
  
  def create
    customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    subscription = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
    subscription.plan = "basic_1"
    subscription.save
    current_user.update_attribute(:plan_id, Plan.find_by_stripe_plan_id('basic_1'))
    redirect_to user_path(current_user.slug)
  end

  def hold
    customer = Stripe::Customer.create(
      :email => current_user.email,
      #:source  => params[:stripeToken],
      :plan => 'basic_1'
    )
    #set and store stripe customer id in our database
    current_user.stripe_customer_id = customer.id
    #get the plan by using the plan's name from the returned stripe object
    @plan = Plan.find_by(:stripe_plan_id => customer.subscriptions.data.first['plan'].id)
    #set our user and plan relationship in our database
    current_user.plan_id = @plan.id
    #set our epoch timestamp returned from stripe in our own database so when know if a user account expired without hitting stripe servers
    current_user.stripe_end_date = customer.subscriptions.data.first.current_period_end
    #set our subscription id from stripe into our customer model. Need this to delete subscriptions later
    current_user.stripe_subscription_id = customer.subscriptions.data.first.id
    #save all of the above into the database
    current_user.save
    #redirect back to the user home.
    redirect_to user_path(current_user.slug)

    #render :text => customer.subscriptions.data.first.id
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path
  end
  
  def update
    cu = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    cu.description = "Kevin's Description"
    cu.save
  end
  
  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    subscription = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
    subscription.plan = "free"
    subscription.proration_date = customer.subscriptions.data.first.current_period_end
    subscription.save
    current_user.update_attribute(:plan_id, Plan.find_by_stripe_plan_id('free'))
    current_user.update_attribute(:stripe_end_date, customer.subscriptions.data.first.current_period_end)
    redirect_to user_path(current_user.slug)
  end
  
  def add_card
    raise "Yeah"
  end
  
  def webhook
    event = Stripe::Event.retrieve(params["id"])
    
    case event.type
      when "customer.subscription.deleted"
      User.find_by_stripe_customer_id(event.data.object.customer)
      render status: :ok, json: "success"
      
      when "customer.subscription.updated"
      user = User.find_by_stripe_customer_id(event.data.object.customer)
      user.update_attribute(:stripe_end_date, event.data.object.current_period_end)
      render status: :ok, json: "success"
      
      when "plan.created"
      Plan.new(:name => event.data.object.name, :stripe_plan_id => event.data.object.id).save
      render status: :ok, json: "success"
      
      when "plan.deleted"
      Plan.find_by_stripe_plan_id(event.data.object.id).delete
      render status: :ok, json: "success"
      
      when "customer.created"
      render status: :ok, json: "success"
      
      when "customer.updated"
      render status: :ok, json: "success"
      
      when "customer.deleted"
      render status: :ok, json: "success"
      
      when "customer.source.created"
      render status: :ok, json: "success"
      
      when "invoice.created"
      render status: :ok, json: "success"
      
      when "invoice.payment_succeeded"
      render status: :ok, json: "success"
      
      when "customer.subscription.created"
      render status: :ok, json: "success"
      
      when "customer.subscription.updated"
      render status: :ok, json: "success"
      
      when "customer.subscription.trial_will_end"
      render status: :ok, json: "success"
      
      when "customer.source.deleted"
      render status: :ok, json: "success"
      
    end
  end
  
  #PUBLISHABLE_KEY=pk_test_6QkkD6iEONfxnnTNxVsrqVgP SECRET_KEY=sk_test_AEjOLK8M1iezL34v77zk83bV rails s -p $PORT -b $IP
  
end
