class CreateReceipts < ActiveRecord::Migration[6.1]
  def change
    create_table :receipts do |t|
      t.date :due_date
      t.date :effective_date
      t.integer :authorization_code
      t.references :charge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
