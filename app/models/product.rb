class Product < ApplicationRecord
  before_create :set_token
  validates :name, :price, presence: :true
  belongs_to :company

  enum status: { active: 0, inactive: 1 }

  scope :available, -> {where(status: :active)}

  def set_token
    token = SecureRandom.alphanumeric(20)
    Product.where(token: token).exists? ? set_token : self.token = token
  end
end
