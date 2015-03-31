class Fitment < ActiveRecord::Base
    belongs_to :part
    belongs_to :machine
end
