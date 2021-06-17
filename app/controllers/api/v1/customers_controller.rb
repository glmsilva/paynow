class Api::V1::CustomersController < ActionController::API
  def index 
  end 

  def create 
    @company = Company.find_by(token: params[:customer][:company_token])
    token = generate_customer_token(params[:customer][:name], params[:customer][:cpf])
    @customer_exists = Customer.find_by(token: token)

    if @customer_exists 
      LogCustomer.create(customer_token: token, company: @company)
      render json: @customer_exists.as_json(only: [:token, :status]) , status: :accepted
    else 
      @customer = Customer.new(token: token)
      log = LogCustomer.new(customer_token: token, company: @company )

      if @customer.save! && log.save!
        render json: @customer.as_json(only: [:token, :status]) , status: :created
      end
      
    end
    rescue ActiveRecord::RecordInvalid
      head 422
  end

  private 

  def generate_customer_token(name, cpf) 
    customer_bind = name + cpf
    customer_bind = Digest::MD5.hexdigest customer_bind 
    customer_bind = customer_bind[0,20]
  end
end