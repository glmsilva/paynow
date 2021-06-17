class CreateCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :charges do |t|
      t.string :company_token
      t.string :product_token
      t.string :payment_method
      t.string :customer_name
      t.string :customer_cpf
      t.string :card_number
      t.string :card_name
      t.integer :verification_code
      t.string :address
      t.decimal :regular_price
      t.decimal :discount_price
      t.string :token
      t.integer :status

      t.timestamps
    end
    add_index :charges, :token, unique: true
  end
end
