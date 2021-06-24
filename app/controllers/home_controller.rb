class HomeController < ApplicationController
  def index
    if current_user && current_user.active?
      if current_user.admin?
        redirect_to admin_index_path
      else
        redirect_to employees_index_path
      end
    end
  end
end
