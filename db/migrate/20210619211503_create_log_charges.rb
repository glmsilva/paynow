class CreateLogCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :log_charges do |t|
      t.integer :return_code
      t.datetime :attempt_date
      t.datetime :effective_date
      t.references :charge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
