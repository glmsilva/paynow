class RemoveAttributeFromLogCompaniesChange < ActiveRecord::Migration[6.1]
  def change
    remove_column :log_companies_changes, :changed_at, :datetime
  end
end
