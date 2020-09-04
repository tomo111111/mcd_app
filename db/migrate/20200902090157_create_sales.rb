class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.integer    :plan,   null: false
      t.integer    :actual
      t.date       :date,   null: false
      t.references :user,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
