class Categorization < ActiveRecord::Base
  belongs_to :machine
  belongs_to :term
  
  accepts_nested_attributes_for :term
end
