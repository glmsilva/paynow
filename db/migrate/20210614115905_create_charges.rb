class CreateCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :charges do |t|
      t.integer :status

      t.timestamps
    end
  end
end
