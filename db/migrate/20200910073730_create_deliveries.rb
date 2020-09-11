class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.string :day_of_week, null: false
      t.boolean :check, default: false, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
