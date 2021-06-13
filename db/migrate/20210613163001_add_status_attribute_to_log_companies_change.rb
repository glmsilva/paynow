class AddStatusAttributeToLogCompaniesChange < ActiveRecord::Migration[6.1]
  def change
    add_column :log_companies_changes, :status, :integer
  end
end
