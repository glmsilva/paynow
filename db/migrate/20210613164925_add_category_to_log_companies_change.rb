class AddCategoryToLogCompaniesChange < ActiveRecord::Migration[6.1]
  def change
    add_column :log_companies_changes, :category, :integer
  end
end
