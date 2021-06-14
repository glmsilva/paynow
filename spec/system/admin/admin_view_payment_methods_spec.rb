require 'rails_helper'

describe 'Admin view Payment Methods' do 
    it 'and view a credit card successfully' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        CreditCard.create!(name: 'MasterCard',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/Mastercard-Logo.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento'

        expect(page).to have_content('MasterCard')
        expect(page).to have_css('img[src*="Mastercard-Logo.png"]')
    end

    it 'and view a boleto successfully' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        Boleto.create!(name: 'Boleto de Banco',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento'

        expect(page).to have_content('Boleto de Banco')
        expect(page).to have_css('img[src*="banco-placeholder.png"]')
    end

    it 'and view a pix successfully' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        Pix.create!(name: 'Pix Banco Vermelho',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento'

        expect(page).to have_content('Pix Banco Vermelho')
        expect(page).to have_css('img[src*="banco-placeholder.png"]')
    end

    it 'and view all avaialable' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        CreditCard.create!(name: 'MasterCard',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/Mastercard-Logo.png')))
        Pix.create!(name: 'Pix Banco Vermelho',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))
        Boleto.create!(name: 'Boleto de Banco',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento'

        expect(page).to have_content('Boleto de Banco')
        expect(page).to have_css('img[src*="banco-placeholder.png"]')
        expect(page).to have_content('MasterCard')
        expect(page).to have_css('img[src*="Mastercard-Logo.png"]')
        expect(page).to have_content('Pix Banco Vermelho')
    end

    it 'and none payment methods are registered' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        login_as admin, scope: :user

        visit root_path 
        click_on 'Métodos de Pagamento'

        expect(page).to have_content('Nenhum cadastrado', count: 3)
    end
end