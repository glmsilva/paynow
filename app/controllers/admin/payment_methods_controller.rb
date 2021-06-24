module Admin 
  class PaymentMethodsController < AdminController
    def index 
      @cards = CreditCard.all 
      @boletos = Boleto.all 
      @pixs = Pix.all
      @boleto = Boleto.new
      @card = CreditCard.new
      @pix = Pix.new
    end
  end
end