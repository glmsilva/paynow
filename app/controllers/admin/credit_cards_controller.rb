module Admin 
  class CreditCardsController < AdminController
	  def new 
	  end
	  def create
	    @card = CreditCard.new(credit_card_params)
	    if @card.save
	      redirect_to admin_credit_card_path(@card), notice: 'Cadastrado com sucesso'
	    else 
	      redirect_to admin_payment_methods_path, alert: 'Não foi possível fazer o cadastro, por favor preencha todos os campos'
	    end
	  end
	  def show 
	      @card = CreditCard.find(params[:id])
	  end
	  def edit 
	      @card = CreditCard.find(params[:id])
	  end
	  def update
	    @card = CreditCard.find(params[:id])
	    @card.update(credit_card_params)
	    redirect_to admin_credit_card_path(@card), notice: 'Atualizado com sucesso'
	  end
	  def inactivate 
			@card = CreditCard.find(params[:id])
	    @card.inactive!
	    @card.save
	    redirect_to admin_credit_card_path(@card), notice: 'Inativado com sucesso'
	  end
	  def activate 
	    @card = CreditCard.find(params[:id])
	    @card.active! 
	    @card.save
	    redirect_to admin_credit_card_path(@card), notice: 'Ativado com sucesso'
	  end
	  private 
	  def credit_card_params
	    params.require(:credit_card).permit(:name, :maxfee, :chargefee, :icon)
	  end
  end
end