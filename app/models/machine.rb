class Machine < ActiveRecord::Base
    has_many :fitments
    has_many :parts, :through => :fitments
    
    extend FriendlyId
    friendly_id :title, use: :slugged
end
