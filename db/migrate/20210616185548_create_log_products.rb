class CreateLogProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :log_products do |t|
      t.references :product, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
