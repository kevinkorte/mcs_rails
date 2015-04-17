class Term < ActiveRecord::Base
  has_many :categorizations, :class_name => 'Categorization'
  has_many :machines, :through => :categorizations
  
  accepts_nested_attributes_for :categorizations
  accepts_nested_attributes_for :machines
end
