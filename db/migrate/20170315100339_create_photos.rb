class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :filename
      t.string :path
      t.string :extname

      t.timestamps
    end
  end
end
