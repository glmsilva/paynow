module Employees
class CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      Employee.create(user: current_user, company: @company)
      current_user.company_admin!
      redirect_to employees_index_path, notice: 'Empresa cadastrada com sucesso. Bem vindo a página da sua empresa.'
    end
  end

  private
  def company_params
    params.require(:company).permit(:name,:cnpj, :billing_address, :billing_email)
  end
end
end