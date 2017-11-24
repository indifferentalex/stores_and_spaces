class CreateSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :spaces do |t|
      t.references :store, foreign_key: true
      t.string :title
      t.integer :size
      t.decimal :price_per_day, precision: 19, scale: 4
      t.decimal :price_per_week, precision: 19, scale: 4
      t.decimal :price_per_month, precision: 19, scale: 4

      t.timestamps
    end
  end
end
