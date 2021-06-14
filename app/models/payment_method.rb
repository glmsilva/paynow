class PaymentMethod < ApplicationRecord
    has_one_attached :icon
    validates :name, :maxfee, :chargefee, presence: :true
    enum status: {active: 0, inactive: 1}
end
