class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :token
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
