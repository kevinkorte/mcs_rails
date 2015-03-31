class Machine < ActiveRecord::Base
    has_many :fitments
    has_many :parts, :through => :fitments
end
