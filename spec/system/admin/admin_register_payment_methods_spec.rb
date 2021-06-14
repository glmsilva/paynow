require 'rails_helper'

describe 'Admin register Payment Methods' do 
    it 'adn register a credit card successfully' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        login_as admin, scope: :user 

        visit root_path 
        click_on 'Pagamentos'
        click_on 'Ver métodos de pagamento'
        click_on 'Registrar novo método de pagamento'
        click_on 'Cartão de Crédito'

        fill_in 'Nome', with: 'Cartão de Crédito PISA'
        fill_in 'Taxa de Cobrança %', with: 6
        fill_in 'Taxa Máxima em R$', with: 50
        attach_file 'Ícone', Rails.root.join('spec/fixtures/pisacard.png')
        click_on 'Cadastrar Cartão de Crédito'

        expect(page).to have_content('Cartão de Crédito PISA')
        expect(page).to have_content('6%')
        expect(page).to have_content('50')
        expect(page).to have_content('img[src*="pisacard.png"]')
    end
end