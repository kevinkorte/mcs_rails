class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :term_id
      t.integer :machine_id
      t.string  :category
      
      t.timestamps
    end
  end
end
