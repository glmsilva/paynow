require 'rails_helper'

describe 'Admin register Payment Methods' do 
    it 'adn register a credit card successfully' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        CreditCard.create!(name: 'MestreCartão',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/pisacard.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento' 
        click_ on 'Editar'

        fill_in 'Nome', with: 'MasterCard'
        fill_in 'Taxa de Cobrança %', with: 5
        fill_in 'Taxa Máxima em R$', with: 100
        attach_file 'Ícone', Rails.root.join('spec/fixtures/Mastercard-Logo.png')
        click_on 'Salvar'

    end
end