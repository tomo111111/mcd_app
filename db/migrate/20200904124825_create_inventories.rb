class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|
      t.integer :order
      t.integer :use
      t.integer :stock
      t.date :date, null: false
      t.references :item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
