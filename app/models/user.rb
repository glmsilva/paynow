class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :lastname, presence: true

  enum status: { active: 0, inactive: 1}
  enum role: { employee: 0, company_admin: 5, admin: 10 }

  def full_name
    "#{name} #{lastname}"
  end

end
