class Make < ActiveRecord::Base
  has_many :machines, -> { uniq }
end
