class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :title
      t.string :city
      t.string :street

      t.timestamps
    end
  end
end
