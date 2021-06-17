class LogCustomer < ApplicationRecord
  validates :customer_token, :company_id, presence: :true
  belongs_to :company
end
