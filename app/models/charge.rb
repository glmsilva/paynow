class Charge < ApplicationRecord
  before_create :set_token
  enum status: { pending: 1, approved: 5 }
  validates :company_token, :product_token, 
  :payment_method, :customer_name, 
  :customer_cpf,
  presence: :true
  has_many :log_charges

  scope :available_pending, -> { where(status: :pending) }
  scope :available_approved, -> { where(status: :approved) }

  def set_token
    token = SecureRandom.alphanumeric(20)
      Charge.where(token: token).exists? ? set_token : self.token = token
  end
end
