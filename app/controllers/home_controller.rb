class HomeController < ApplicationController
  def index
    if current_user && current_user.active?
      company = current_user.domain
      if company == 'paynow'
        current_user.admin!
        redirect_to admin_index_path
      else
        redirect_to employees_index_path
      end
    else

    end
  end
end
