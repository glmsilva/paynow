class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.decimal :chargefee
      t.integer :maxfee
      t.integer :status
      t.string :type

      t.timestamps
    end
  end
end
