class PlansController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  require 'json'
  
  Stripe.api_key = "sk_test_AEjOLK8M1iezL34v77zk83bV"
  
  def receiver
    data_json = JSON.parse request.body.read
    customer = data_json['data']['object']['customer']
    
    status 200
  end
  
end
