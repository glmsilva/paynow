class Company < ApplicationRecord
  has_many :employees
  enum status: {active: 0, inactive: 1}
end
