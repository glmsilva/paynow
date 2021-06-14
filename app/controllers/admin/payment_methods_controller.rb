module Admin 
    class PaymentMethodsController < AdminController
        def index 
            @cards = CreditCard.all 
            @boletos = Boleto.all 
            @pixs = Pix.all
        end
    end
end