module Admin 
  class CompaniesController < AdminController 
    def index 
      @companies = Company.available
      @total_employees = Employee.all.size
    end
    def edit
      @company = Company.find(params[:id])
    end
    def update 
      @company = Company.find(params[:id])
      @company.update(company_params)
      LogCompaniesChange.create(user: current_user, company: @company, category: 0, status: 0)
      redirect_to admin_company_path(@company), notice: 'Cliente atualizado com sucesso'
    end
    def show 
      @company = Company.find(params[:id])
    end
    def inactivate
      @company = Company.find(params[:id])
      log = LogCompaniesChange.find_by(company: @company)
      if log 
        if log.pending? && log.user != current_user 
          log.approved!
          @company.inactive!
          redirect_to admin_company_path(@company), notice: 'Cliente inativado com sucesso'
        else
          redirect_to admin_company_path(@company), alert: 'Desculpe, você não tem autorização para fazer isso'
        end
      else
        LogCompaniesChange.create(user: current_user, company: @company, category: :suspension, status: 1)
        redirect_to admin_company_path(@company), notice: 'Cliente em pendência para ser inativado'
      end
    end

    def show_inactivates
      @companies = Company.unavailable
    end
    def activate 
      @company = Company.find(params[:id])
      log = LogCompaniesChange.find_by(company: @company)
      if log.approved? && log.suspension?
        @company.active!
        LogCompaniesChange.create(user: current_user, company: @company, category: :modification, status: 0)
        redirect_to admin_company_path(@company), notice: 'Cliente reativado com sucesso'
      end
    end
    def change_token 
      @company = Company.find(params[:id])
      @company.set_token
      @company.save
      LogCompaniesChange.create(user: current_user, company: @company, category: :modification, status: :approved)
      redirect_to admin_company_path(@company), notice: 'Cliente atualizado com sucesso'
    end

    private 

    def company_params
      params.require(:company).permit(:name, :cnpj, :billing_address, :billing_email)
    end
  end
end