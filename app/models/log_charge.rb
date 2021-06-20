class LogCharge < ApplicationRecord
  belongs_to :charge

  enum return_code: { pendente: 1, efetivada: 5, sem_credito: 9, dados_incorretos: 10, recusada: 11 }
end
