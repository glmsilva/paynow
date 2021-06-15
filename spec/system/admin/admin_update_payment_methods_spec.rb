require 'rails_helper'

describe 'Admin update Payment Methods' do 
    it 'and update a credit card successfully' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        CreditCard.create!(name: 'MestreCartão',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/pisacard.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento' 
        click_on 'Editar'

        fill_in 'Nome', with: 'MasterCard'
        fill_in 'Taxa de Cobrança %', with: 5
        fill_in 'Taxa Máxima em R$', with: 100
        attach_file 'Ícone', Rails.root.join('spec/fixtures/Mastercard-Logo.png')
        click_on 'Salvar'

        expect(page).to have_content('Atualizado com sucesso')
    end

    it 'and update a boleto successfully' do
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        Boleto.create!(name: 'Boleto Banco Vermelho',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/pisacard.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento' 
        click_on 'Editar'

        fill_in 'Nome', with: 'Boleto Banco Azul'
        fill_in 'Taxa de Cobrança %', with: 5
        fill_in 'Taxa Máxima em R$', with: 100
        attach_file 'Ícone', Rails.root.join('spec/fixtures/banco-placeholder.png')
        click_on 'Salvar'

        expect(page).to have_content('Atualizado com sucesso')
    end

    it 'and update a pix successfully' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        Pix.create!(name: 'Pix Banco Laranja',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/pisacard.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento' 
        click_on 'Editar'

        fill_in 'Nome', with: 'Pix Banco Azul'
        fill_in 'Taxa de Cobrança %', with: 5
        fill_in 'Taxa Máxima em R$', with: 100
        attach_file 'Ícone', Rails.root.join('spec/fixtures/banco-placeholder.png')
        click_on 'Salvar'

        expect(page).to have_content('Atualizado com sucesso')
    end

    it 'and inactivate a credit card' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        CreditCard.create!(name: 'MestreCartão',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/pisacard.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento' 
        click_on 'Editar'
        click_on 'Inativar'

        expect(page).to have_content('Inativado com sucesso')
        expect(page).to have_link('Ativar')
    end

    it 'and activate a credit card' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        CreditCard.create!(name: 'MestreCartão',chargefee: 10, maxfee: 50, status: 1, icon: fixture_file_upload(Rails.root.join('spec/fixtures/pisacard.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento' 
        click_on 'Editar'
        click_on 'Ativar'

        expect(page).to have_content('Ativado com sucesso')
        expect(page).to have_link('Inativar')
    end

    it 'and inactivate a boleto' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        Boleto.create!(name: 'Boleto Banco Vermelho',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento' 
        click_on 'Editar'
        click_on 'Inativar'

        expect(page).to have_content('Inativado com sucesso')
        expect(page).to have_link('Ativar')
    end

    it 'and activate a boleto' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        Boleto.create!(name: 'Boleto Banco Vermelho',chargefee: 10, maxfee: 50, status: 1, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento' 
        click_on 'Editar'
        click_on 'Ativar'

        expect(page).to have_content('Ativado com sucesso')
        expect(page).to have_link('Inativar')
    end

    it 'and inactivate a pix' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        Pix.create!(name: 'Pix Banco Laranja',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento' 
        click_on 'Editar'
        click_on 'Inativar'

        expect(page).to have_content('Inativado com sucesso')
        expect(page).to have_link('Ativar')
    end

    it 'and activate a pix' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        Pix.create!(name: 'Pix Banco Laranja',chargefee: 10, maxfee: 50, status: 1, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento' 
        click_on 'Editar'
        click_on 'Ativar'

        expect(page).to have_content('Ativado com sucesso')
        expect(page).to have_link('Inativar')
    end

    it 'and return to payment methods page' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        Pix.create!(name: 'Pix Banco Laranja',chargefee: 10, maxfee: 50, status: 1, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))

        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento' 
        click_on 'Editar'
        click_on 'Voltar'

        expect(page).to have_content("Pix Banco Laranja")
    end
end