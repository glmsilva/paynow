class LogCompaniesChange < ApplicationRecord
  belongs_to :user
  belongs_to :company

  enum category: {modification: 0, suspension: 1}
  enum status: {approved: 0, pending: 1, denied: 2}

end
