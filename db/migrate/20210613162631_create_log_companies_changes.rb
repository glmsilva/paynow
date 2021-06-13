class CreateLogCompaniesChanges < ActiveRecord::Migration[6.1]
  def change
    create_table :log_companies_changes do |t|
      t.datetime :changed_at
      t.integer :type
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
