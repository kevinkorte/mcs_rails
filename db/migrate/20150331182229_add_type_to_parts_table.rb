class AddTypeToPartsTable < ActiveRecord::Migration
  def change
    change_table :parts do |t|
      add_column :parts, :type, :string
    end
  end
end
