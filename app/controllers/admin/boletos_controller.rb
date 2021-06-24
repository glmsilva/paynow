module Admin 
  class BoletosController < AdminController
    def create
      @boleto = Boleto.new(boleto_params)
      if @boleto.save
        redirect_to admin_boleto_path(@boleto), notice: 'Cadastrado com sucesso'
      else 
        redirect_to admin_payment_methods_path, alert: 'Não foi possível fazer o cadastro, por favor preencha todos os campos'
      end
    end
    def show 
      @boleto = Boleto.find(params[:id])
    end
    def edit 
      @boleto = Boleto.find(params[:id])
    end
    def update
      @boleto = Boleto.find(params[:id])
      @boleto.update(boleto_params)
      redirect_to admin_boleto_path(@boleto), notice: 'Atualizado com sucesso'
    end
    def inactivate 
      @boleto = Boleto.find(params[:id])
      @boleto.inactive!
      @boleto.save
      redirect_to admin_boleto_path(@boleto), notice: 'Inativado com sucesso'
    end
    def activate 
      @boleto = Boleto.find(params[:id])
      @boleto.active! 
      @boleto.save
      redirect_to admin_boleto_path(@boleto), notice: 'Ativado com sucesso'
    end
    private
    def boleto_params 
      params.require(:boleto).permit(:name, :chargefee,:maxfee, :icon)
    end
  end
end