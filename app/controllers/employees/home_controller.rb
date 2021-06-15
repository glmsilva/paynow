module Employees
  class HomeController < EmployeesController
    def index
      company_name = current_user.domain.capitalize
      @company = Company.find_by(name: company_name)
      if @company
        @greetings = "Bem vindo, #{current_user.full_name}"
        @token = @company.token
      else
        redirect_to new_employees_company_path
      end
    end
  end
end