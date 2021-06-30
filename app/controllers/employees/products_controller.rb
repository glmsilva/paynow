module  Employees
  class ProductsController < EmployeesController 
    def index 
      @products = Product.available
      @product = Product.new
    end

    def create 
      @company = Employee.find_by(user: current_user).company
      @product = Product.new(product_params)
      @product.company = @company
      if @product.save 
          redirect_to employees_product_path(@product), notice: 'Produto Cadastrado com sucesso'
      else 
          render js: "alert('Não foi possível cadastrar, preencha todos os campos')"
      end
    end

    def show 
        @product = Product.find(params[:id])
    end

    def edit 
        @product = Product.find(params[:id])
    end

    def update 
        @product = Product.find(params[:id])
        price = @product.price
        @employee = Employee.find_by(user: current_user)
        if @product.update(product_params)
            LogProduct.create(product: @product, employee: @employee, price: price)
            redirect_to employees_product_path(@product), notice: 'Atualizado com sucesso'
        else 
          render :edit, notice: 'Não foi possível atualizar'
        end
    end

    private
    
    def product_params 
        params.require(:product).permit(:name, :price,:boleto, :credit, :pix)
    end
  end
end