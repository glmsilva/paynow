module Employees
  class HomeController < EmployeesController
    def index
      company = current_user.domain.capitalize
      @company_exists = Company.find_by(name: company)
      if @company_exists
        @greetings = "Bem vindo, #{current_user.full_name}"
      else
        redirect_to new_employees_company_path
      end

    end
  end
end