class LogCompaniesChange < ApplicationRecord
  belongs_to :user
  belongs_to :company

  enum category: {modification: 0, suspension: 1}
  enum status: {approved: 0, pending: 1, denied: 2}

  def inactivate_company(company, user)
    if self.pending? && self.user != user 
      self.approved! 
      company.inactive!
    end
  end

  def activate_company(company)
    if self.approved? && self.suspension?
      company.active!
    end 
  end

end
