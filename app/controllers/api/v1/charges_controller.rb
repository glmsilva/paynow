module Api 
  module V1 
    class ChargesController < ApiController
      def create 
        @charge = Charge.new(charge_params)
        @company = Company.find_by!(token: params[:charge][:company_token])
        customer_token = generate_customer_token(params[:charge][:customer_name],params[:charge][:customer_cpf] )
        @customer = LogCustomer.find_by!(customer_token: customer_token, company: @company)
        @product = Product.find_by!(token: params[:charge][:product_token])
        @payment_method = PaymentMethod.find_by!(name: params[:charge][:payment_method])
        @registered_payment_method = PaymentMethodsCompany.find_by!(payment_method: @payment_method, company: @company)
        @charge.payment_method = @payment_method.name
        if @payment_method.type == 'Boleto'
          @charge.discount_price = set_discount(@product.price, @product.boleto)
          if !params[:charge][:address]
            render json: {erro: "Endereço não pode ficar em branco"}, status: :unprocessable_entity and return
          end
        elsif @payment_method.type == 'CreditCard'
          @charge.discount_price = set_discount(@product.price,@product.credit) 
        elsif @payment_method.type == 'Pix'
          @charge.discount_price = set_discount(@product.price,@product.pix)
        end
        @charge.regular_price = @product.price

        @charge.save!
          render json: @charge.as_json(except: [:id, :updated_at]), status: :created
          
      end

      private 
      
      def charge_params 
        params.require(:charge).permit(:company_token, :product_token,:payment_method, :customer_name, :customer_cpf, :card_number, :card_name, :verification_code, :address)
      end
      
      def set_discount(param1, param2)
        param1 - param1/param2
      end


    end
  end
end