class Part < ActiveRecord::Base
    has_many :fitments
    has_many :machines, :through => :fitments
    
    def machine_ids=(machine_ids)
        fitments.each do |fitment|
            fitment.destroy unless machine_ids.include? fitment.machine_id
        end
        
        machine_ids.each do |machine_id|
            self.fitments.create(:machine_id => machine_id) unless fitments.any? { |d| d.machine_id == machine_id }
        end
    end
    
    
    
end
