class CreateFitments < ActiveRecord::Migration
  def change
    create_table :fitments do |t|
      t.integer :part_id
      t.integer :machine_id
      t.integer :position

      t.timestamps
    end
  end
end
