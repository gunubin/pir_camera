class ChangeColumnToFace < ActiveRecord::Migration[5.0]
  def change
    change_column :faces, :bounds, :text
    change_column :faces, :angles, :text
    change_column :faces, :features, :text
  end
end
