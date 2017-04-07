class CreateFaces < ActiveRecord::Migration[5.0]
  def change
    create_table :faces do |t|
      t.references :photoAPI, foreign_key: true
      t.integer :confidence
      t.string :anger
      t.string :blurred
      t.string :headwear
      t.string :joy
      t.string :sorrow
      t.string :surprise
      t.string :under_exposed

      t.timestamps
    end
  end
end
