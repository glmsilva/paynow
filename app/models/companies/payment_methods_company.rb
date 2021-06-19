class PaymentMethodsCompany < ApplicationRecord
  belongs_to :company
  belongs_to :payment_method

  enum status: {active: 0, inactive: 1}
end
