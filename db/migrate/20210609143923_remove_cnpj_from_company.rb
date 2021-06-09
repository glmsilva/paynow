class RemoveCnpjFromCompany < ActiveRecord::Migration[6.1]
  def change
    remove_column :companies, :cnpj, :integer
  end
end
