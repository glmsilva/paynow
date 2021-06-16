module Employees
    class PaymentMethodsCompaniesController < EmployeesController
        def index 
            @company = Employee.find_by(user: current_user).company
            @payment_methods_available = PaymentMethod.where(status: :active)
            @registered_methods = PaymentMethodsCompany.where(company: @company, status: :active)
        end

        def create 
            @company = Employee.find_by(user: current_user).company
            @payment_method = PaymentMethod.find(params[:payment_method_id])
            if @payment_method.type == "Boleto"
                boleto = BoletoCompany.new(method_params)
                boleto.company = @company
                boleto.payment_method = @payment_method
                boleto.save
            end
            if @payment_method.type == "CreditCard"
                card = CreditCardCompany.new(method_params)
                card.company = @company
                card.payment_method = @payment_method
                card.save
            end
            if @payment_method.type == "Pix"
                pix = PixCompany.new(method_params)
                pix.company = @company
                pix.payment_method = @payment_method
                pix.save
            end

            redirect_to employees_metodos_pagamento_path, notice: 'Método de Pagamento Cadastrado'
        end

        def show 
            #@company = Employee.find_by(user: current_user).company
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