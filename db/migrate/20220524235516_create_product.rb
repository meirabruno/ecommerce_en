class CreateProduct < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title, null: false, default: ''
      t.text :description, null: false, default: ''
      t.string :status, null: false, default: 'draft'
      t.string :tags, default: [], array: true
      t.integer :price, null: false, default: 0
      t.integer :comparation_price
      t.timestamps
    end
  end
end
