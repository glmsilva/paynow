module Api 
  module V1 
    class ChargesController < ActionController::API
      def create 
        @charge = Charge.new(charge_params)
        @product = Product.find_by(token: params[:charge][:product_token])
        if @charge.payment_method == 'boleto'
          @charge.discount_price = set_discount(@product.price, @product.boleto)
        elsif @charge.payment_method == 'credit'
          @charge.discount_price = set_discount(@product.price,@product.credit) 
        else 
          @charge.discount_price = set_discount(@product.price,@product.pix)
        end
        @charge.regular_price = @product.price

        if @charge.save! 
          render json: @charge.as_json(except: [:id, :updated_at]), status: :created
        end



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