require 'rails_helper'

describe 'Admin register Payment Methods' do 
    it 'and register a credit card successfully' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        CreditCard.create!(name: 'MasterCard',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/Mastercard-Logo.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento'

        expect(page).to have_content('MasterCard')
        expect(page).to have_css('img[src*="Mastercard-Logo.png"]')
    end
end