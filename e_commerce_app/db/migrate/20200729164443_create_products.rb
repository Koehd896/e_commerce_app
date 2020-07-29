class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.decimal :price, :precision => 8, :scale => 2
      t.string :description
      t.integer :cart_id
      t.integer :user_id
    end
  end
end
