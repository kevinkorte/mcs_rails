class AddStripeDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :users, :stripe_subscription_id, :string
    add_column :users, :plan_id, :string, index: true
    add_column :users, :stripe_end_date, :time
  end
end
