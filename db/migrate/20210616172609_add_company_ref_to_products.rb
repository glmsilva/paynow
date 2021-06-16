class AddCompanyRefToProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :company, null: false, foreign_key: true
  end
end
