class AddColumnToFace < ActiveRecord::Migration[5.0]
  def change
    add_column :faces, :bounds, :string
    add_column :faces, :angles, :string
    add_column :faces, :features, :string
  end
end
