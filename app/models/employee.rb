class Employee < ApplicationRecord
  belongs_to :user
  belongs_to :company

  has_many :payment_methods_companies

  enum status: {active: 0, inactive: 1}

  scope :available, -> {where(status: :active)}
end
