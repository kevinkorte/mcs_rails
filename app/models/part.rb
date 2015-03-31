class Part < ActiveRecord::Base
    has_many :fitments
    has_many :machines, :through => :fitments
end
