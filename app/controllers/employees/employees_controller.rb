module Employees
  class EmployeesController < ApplicationController
    before_action :authenticate_user!
    before_action :employee_access

    def index 
      @employees = Employee.available
    end

    private

    def employee_access
      redirect_to root_path unless (current_user.employee? || current_user.company_admin?) && current_user.active?
    end
  end
end