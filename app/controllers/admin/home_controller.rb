module Admin
  class HomeController < AdminController
    def index
      @greetings = "Bem vindo, #{current_user.full_name}"
    end
  end
end