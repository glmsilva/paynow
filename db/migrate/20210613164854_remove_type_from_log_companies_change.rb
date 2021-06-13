class RemoveTypeFromLogCompaniesChange < ActiveRecord::Migration[6.1]
  def change
    remove_column :log_companies_changes, :type, :integer
  end
end
