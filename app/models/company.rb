class Company < ApplicationRecord
  before_create :set_token
  has_many :employees
  has_many :users, through: :employees
  enum status: {active: 0, inactive: 1}

  validates :name, :billing_address, :billing_email, presence: :true
  validates :cnpj, length: { is: 14 }, presence: :true

  def set_token
      token = SecureRandom.alphanumeric(20)
      self.token = token unless Company.where(token: token).exists?
  end
end
