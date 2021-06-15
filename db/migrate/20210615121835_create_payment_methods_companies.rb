class CreatePaymentMethodsCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods_companies do |t|
      t.references :company, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true
      t.integer :bank_code
      t.integer :code
      t.integer :branch_code
      t.integer :bank_account
      t.integer :status, default: 0
      t.string :type

      t.timestamps
    end
  end
end
