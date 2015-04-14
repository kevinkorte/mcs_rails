class Year < ActiveRecord::Base
  has_many :machines, -> { uniq }
end
