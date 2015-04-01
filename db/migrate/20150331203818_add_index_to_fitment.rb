class AddIndexToFitment < ActiveRecord::Migration
  def change
    add_index :fitments, :part_id
    add_index :fitments, :machine_id
  end
end
