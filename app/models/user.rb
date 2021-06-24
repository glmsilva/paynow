class User < ApplicationRecord
  after_create :admin_privileges
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :lastname, presence: true
  validates :email, presence: true, email: true
  enum status: { active: 0, inactive: 1}
  enum role: { employee: 0, company_admin: 5, admin: 10 }


  def admin_privileges 
    if self.domain == "paynow" 
      self.admin!
    end
  end

  def full_name
    "#{name} #{lastname}"
  end

  def domain
    email.split('@').last.split('.').first
  end

  def active_for_authentication?
    super && active?
  end

  #def inactive_message
  # "Conta desativada"
    #end



end
