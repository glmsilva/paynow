module Admin 
    class PaymentMethodsController < AdminController
        def index 
            @payment_methods = PaymentMethod.all
            @cards = CreditCard.all 
            @boletos = Boleto.all 
            @pixs = Pix.all
        end
    end
end