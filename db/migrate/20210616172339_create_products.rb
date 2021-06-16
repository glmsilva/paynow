class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.integer :boleto
      t.integer :credit
      t.integer :pix
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
