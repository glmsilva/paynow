class AddAttributesToCharge < ActiveRecord::Migration[6.1]
  def change
    add_column :charges, :due_date, :date
  end
end
