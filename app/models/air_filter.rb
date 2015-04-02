class AirFilter < Part
  #fixes our STI link to helpers so we use the Part Controller instead of the this classes controller
  #http://stackoverflow.com/questions/4507149/best-practices-to-handle-routes-for-sti-subclasses-in-rails
  def self.model_name
    Part.model_name
  end
end