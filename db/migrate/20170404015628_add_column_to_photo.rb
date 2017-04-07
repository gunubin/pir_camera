class AddColumnToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :favorite, :boolean
  end
end
