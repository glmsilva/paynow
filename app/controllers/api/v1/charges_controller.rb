module Api 
  module V1 
    class ChargesController < ApiController
      def index 
        if params[:charge][:due_date] && params[:charge][:payment_method] 
          @charge = Charge.where(due_date: params[:charge][:due_date], 
                                 payment_method: params[:charge][:payment_method])
          render json: @charge, status: :accepted
        elsif params[:charge][:due_date] || params[:charge][:payment_method]
          @charge = Charge.where(due_date: params[:charge][:due_date])
                                .or(Charge.where(payment_method: params[:charge][:payment_method]))
          render json: @charge, status: :accepted
        end
      end

      def create 
        @charge = Charge.new(charge_params)
        @product = Product.find_by!(token: params[:charge][:product_token])
        @charge.apply_discount(@product)
        @charge.regular_price = @product.price

        @charge.save!
          render json: @charge.as_json(except: [:id, :updated_at]), status: :created
          
      end

      def update 
        @charge = Charge.find_by!(token: params[:charge][:token])
        @log = LogCharge.create!(return_code: params[:charge][:status].to_i, 
                                 attempt_date: Date.today, charge: @charge)
        if @log.approved?
          @charge.approved!
          @log.effective_date = Date.today
          
        else 
          @charge.pending!
        end

        render json: @log.as_json(except: [:id, :charge_id, :update_at, :created_at], 
                                  include: { charge: { 
                                    except: [:id, :updated_at]
                                    }
                                  }
                                  ), status: :accepted
      end

      private 
      
      def charge_params 
        params.require(:charge).permit(:company_token, :product_token, :payment_method, :customer_name, :customer_cpf, :card_number, :card_name, :verification_code, :address)
      end
      
      
    end
  end
end