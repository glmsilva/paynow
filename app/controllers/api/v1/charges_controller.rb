module Api 
  module V1 
    class ChargesController < ActionController::API
      def create 
        @charge = Charge.new(charge_params)
        @product = Product.find_by(token: params[:charge][:product_token])
        if !@product
          render json: {produto: 'não pode ficar em branco'}, status: :unprocessable_entity and return
        end

        if @charge.payment_method == 'boleto'
          @charge.discount_price = set_discount(@product.price, @product.boleto)
        elsif @charge.payment_method == 'credit'
          @charge.discount_price = set_discount(@product.price,@product.credit) 
        elsif @charge.payment_method == 'pix'
          @charge.discount_price = set_discount(@product.price,@product.pix)
        end
        @charge.regular_price = @product.price

        @charge.save!
          render json: @charge.as_json(except: [:id, :updated_at]), status: :created

      rescue ActiveRecord::RecordInvalid
          render json: @charge.errors, status: :unprocessable_entity
      rescue ActionController::ParameterMissing
        render json: {errors: 'parece que você não enviou nenhum parametro ou o valor é vazio, preencha e envie novamente.'}, 
        status: :precondition_failed
      end

      private 
      
      def charge_params 
        params.require(:charge).permit(:company_token, :product_token, :payment_method, :customer_name, :customer_cpf, :card_number, :card_name, :verification_code, :address)
      end
      
      def set_discount(param1, param2)
        param1 - param1/param2
      end
    end
  end
end