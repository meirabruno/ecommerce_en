class CreateCategorization < ActiveRecord::Migration[7.0]
  def change
    create_table :categorizations do |t|
      t.references :product, foreign_key: true, index: true
      t.references :category, foreign_key: true, index: true
      t.timestamps
    end
  end
end
