module Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_access

    private

    def admin_access
      redirect_to root_path unless current_user.admin?
    end
  end
end
