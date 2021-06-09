class HomeController < ApplicationController
  def index
    if current_user
      company = current_user.domain
      if company == 'paynow'
        current_user.admin!
        redirect_to admin_index_path
      else
        redirect_to employees_index_path
      end
    end
  end
end
