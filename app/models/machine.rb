class Machine < ActiveRecord::Base
    has_many :fitments
    has_many :parts, :through => :fitments
    
    has_many :categorizations, :class_name => 'Categorization'
    has_many :terms, :through => :categorizations
    
    accepts_nested_attributes_for :terms
    accepts_nested_attributes_for :categorizations
    
    extend FriendlyId
    friendly_id :title, use: :slugged
    
    validates :title, :presence => true, :uniqueness => true
    
    def self.search(search)
        if search
            where('title LIKE ?', "%#{search}%")
        else
            all
        end
    end

end
