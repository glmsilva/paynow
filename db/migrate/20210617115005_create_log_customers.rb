class CreateLogCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :log_customers do |t|
      t.string :customer_token
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
