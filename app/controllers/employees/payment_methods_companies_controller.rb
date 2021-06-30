module Employees
  class PaymentMethodsCompaniesController < EmployeesController
    def index 
      @company = Employee.find_by(user: current_user).company
      @payment_methods_available = PaymentMethod.available
      @registered_methods = PaymentMethodsCompany.where(company: @company, status: :active)
    end

    def create 
      @company = Employee.find_by(user: current_user).company
      @payment_method = PaymentMethod.find(params[:payment_method_id])
      pm = PaymentMethodsCompany.new(method_params)
      pm.type = "#{@payment_method.type}Company"
      pm.company = @company
      pm.payment_method = @payment_method
      pm.save!
      redirect_to employees_metodos_pagamento_path, notice: 'Método de Pagamento Cadastrado'
    end

    def show 
      @registered_method = PaymentMethodsCompany.find(params[:id])
      @payment_method = @registered_method.payment_method
    end

    def inactivate 
      @payment_method = PaymentMethodsCompany.find(params[:id])
      @payment_method.inactive! 
      redirect_to employees_metodos_pagamento_path, notice: 'Inativado com sucesso'
    end

    private 
    
    def method_params 
      params.require(:payment_methods_company).permit(:code, :bank_code, :bank_account, :branch_code, :payment_method_id)
    end
  end
end