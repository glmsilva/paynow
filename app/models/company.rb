class Company < ApplicationRecord
  before_create :set_token
  has_many :employees
  has_many :users, through: :employees
  has_many :products
  
  enum status: {active: 0, inactive: 1}

  validates :name, :billing_address, :billing_email, presence: :true
  validates :cnpj, length: { is: 14 }, presence: :true

  scope :available, -> {where(status: :active)}

  def set_token
      token = SecureRandom.alphanumeric(20)
      Company.where(token: token).exists? ? set_token : self.token = token
  end
end
