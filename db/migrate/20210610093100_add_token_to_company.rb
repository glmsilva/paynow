class AddTokenToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :token, :string
    add_index :companies, :token, unique: true
  end
end
