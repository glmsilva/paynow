module Api
  module V1 
    class ApiController < ActionController::API 
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActionController::ParameterMissing, with: :parameter_missing

      private 

      def record_invalid(exception) 
        render json: exception.record.errors, status: :unprocessable_entity
      end

      def not_found 
        render json: {} ,status: :not_found
      end

      def parameter_missing 
        render json: {errors: 'parece que você não enviou nenhum parametro ou o valor é vazio, preencha e envie novamente.'}, 
        status: :precondition_failed
      end

      def generate_customer_token(name, cpf) 
        customer_bind = name + cpf
        customer_bind = Digest::MD5.hexdigest customer_bind 
        customer_bind = customer_bind[0,20]
      end

    end
  end
end