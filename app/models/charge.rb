class Charge < ApplicationRecord
  before_create :set_token
  enum status: { pendente: 1, efetivada: 5, sem_credito: 9, dados_incorretos: 10, recusada: 11 }
  validates :company_token, :product_token, 
  :payment_method, :customer_name, 
  :customer_cpf,
  presence: :true

  def set_token
    token = SecureRandom.alphanumeric(20)
    self.token = token unless Charge.where(token: token).exists?
  end
end
