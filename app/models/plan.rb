class Plan < ActiveRecord::Base
  has_many :users, inverse_of: :plan
end
