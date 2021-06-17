class Product < ApplicationRecord
  before_create :set_token
  validates :name, :price, presence: :true
  belongs_to :company

  enum status: { active: 0, inactive: 1 }

  def set_token
    token = SecureRandom.alphanumeric(20)
    self.token = token unless Product.where(token: token).exists?
  end
end
