module Admin 
    class PixesController < AdminController 
        def create
            @pix = Pix.new(pix_params)
            if @pix.save
                redirect_to admin_pix_path(@pix), notice: 'Cadastrado com sucesso'
            else 
                redirect_to admin_payment_methods_path, alert: 'Não foi possível fazer o cadastro, por favor preencha todos os campos'
            end
        end

        def show 
            @pix = Pix.find(params[:id])
        end

        def edit 
            @pix = Pix.find(params[:id])
        end

        def update
            @pix = Pix.find(params[:id])
            @pix.update(pix_params)
            redirect_to admin_pix_path(@pix), notice: 'Atualizado com sucesso'
        end

        def inactivate 
            @pix = Pix.find(params[:id])
            @pix.inactive!
            @pix.save
            redirect_to admin_pix_path(@pix), notice: 'Inativado com sucesso'
        end

        def activate 
            @pix = Pix.find(params[:id])
            @pix.active! 
            @pix.save
            redirect_to admin_pix_path(@pix), notice: 'Ativado com sucesso'
        end

        private

        def pix_params 
            params.require(:pix).permit(:name, :chargefee,:maxfee, :icon)
        end
    end
end