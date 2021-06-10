class Employee < ApplicationRecord
  belongs_to :user
  belongs_to :company

  enum status: {active: 0, inactive: 1}
end
