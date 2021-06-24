class LogCharge < ApplicationRecord
  belongs_to :charge

  enum return_code: { pending: 1, approved: 5, no_credit: 9, incorrect_data: 10, refused: 11 }
end
