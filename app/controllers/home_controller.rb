class HomeController < ApplicationController
  def index
    if current_user
      company = current_user.email.split('@').last.split('.').first
      if company == 'paynow'
        current_user.admin!
        redirect_to admin_index_path
      end
    end

  end
end
