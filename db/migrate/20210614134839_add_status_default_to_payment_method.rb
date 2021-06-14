class AddStatusDefaultToPaymentMethod < ActiveRecord::Migration[6.1]
  def change
    change_column :payment_methods, :status, :integer, default: 0
  end
end
