class ReceiptsController < ApplicationController 
  def show 
    @receipt = Receipt.find_by(slug: params[:slug])
    @company = Company.find_by(token: @receipt.charge.company_token)
    @product = Product.find_by(token: @receipt.charge.product_token)
  end
end