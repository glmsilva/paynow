class AddSlugToReceipt < ActiveRecord::Migration[6.1]
  def change
    add_column :receipts, :slug, :string
  end
end
