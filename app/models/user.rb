class User < ActiveRecord::Base
  belongs_to :plan, inverse_of: :users
  extend FriendlyId
    friendly_id :username, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         

end
