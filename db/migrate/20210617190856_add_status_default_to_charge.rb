class AddStatusDefaultToCharge < ActiveRecord::Migration[6.1]
  def change
    change_column :charges, :status, :integer, default: 1
  end
end
