class Machine < ActiveRecord::Base
    belongs_to :year, :class_name => 'Year', :foreign_key => 'year_id'
    belongs_to :make, :class_name => 'Make', :foreign_key => 'make_id'
    belongs_to :model
    has_many :fitments
    has_many :parts, :through => :fitments
    
    accepts_nested_attributes_for :year
    accepts_nested_attributes_for :make
    accepts_nested_attributes_for :model
    
    
    
    extend FriendlyId
    friendly_id :title, use: :slugged
end
