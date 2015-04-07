class AddSlugToMachines < ActiveRecord::Migration
  def change
    add_column :machines, :slug, :string
    add_index :machines, :slug
  end
end
