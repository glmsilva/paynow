require 'rails_helper'

describe 'Admin register Payment Methods' do 
    it 'and register a credit card successfully' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento'
        click_on 'Cadastrar novo cartão'

        find(:css, '#cardtrigger').fill_in 'Nome', with: 'Cartão de Crédito PISA'
        find(:css, '#cardtrigger').fill_in 'Taxa de Cobrança %', with: 6
        find(:css, '#cardtrigger').fill_in 'Taxa Máxima em R$', with: 50
        find(:css, '#cardtrigger').attach_file 'Ícone', Rails.root.join('spec/fixtures/pisacard.png')
        click_on 'Cadastrar Cartão de Crédito'

        expect(page).to have_content('Cadastrado com sucesso')
        expect(page).to have_content('Cartão de Crédito PISA')
        expect(page).to have_content('6,0%')
        expect(page).to have_content('50')
        expect(page).to have_css('img[src*="pisacard.png"]')
    end

    it 'and leave attributes blank' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento'
        click_on 'Cadastrar novo cartão'
        click_on 'Cadastrar Cartão de Crédito'

        expect(page).to have_content('Não foi possível fazer o cadastro, por favor preencha todos os campos')
    end

    it 'and register a  boleto successfully' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento'
        click_on 'Cadastrar novo boleto'

        find(:css, '#boletotrigger').fill_in 'Nome', with: 'Boleto Banco Vermelho'
        find(:css, '#boletotrigger').fill_in 'Taxa de Cobrança %', with: 4
        find(:css, '#boletotrigger').fill_in 'Taxa Máxima em R$', with: 30
        find(:css, '#boletotrigger').attach_file 'Ícone', Rails.root.join('spec/fixtures/banco-placeholder.png')
        click_on 'Cadastrar Boleto Bancário'

        expect(page).to have_content('Cadastrado com sucesso')
        expect(page).to have_content('Boleto Banco Vermelho')
        expect(page).to have_content('4,0%')
        expect(page).to have_content('30')
        expect(page).to have_css('img[src*="banco-placeholder.png"]')
    end

    it 'and leave attributes blank' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento'
        click_on 'Cadastrar novo boleto'
        click_on 'Cadastrar Boleto Bancário'

        expect(page).to have_content('Não foi possível fazer o cadastro, por favor preencha todos os campos')
    end

    it 'and register a pix successfully' do 
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        login_as admin, scope: :user 

        visit root_path 
        click_on 'Métodos de Pagamento'
        click_on 'Cadastrar novo pix'

        find(:css, '#pixtrigger').fill_in 'Nome', with: 'Pix do Banco Azul'
        find(:css, '#pixtrigger').fill_in 'Taxa de Cobrança %', with: 4
        find(:css, '#pixtrigger').fill_in 'Taxa Máxima em R$', with: 30
        find(:css, '#pixtrigger').attach_file 'Ícone', Rails.root.join('spec/fixtures/banco-placeholder.png')
        click_on 'Cadastrar Pix'

        expect(page).to have_content('Cadastrado com sucesso')
        expect(page).to have_content('Pix do Banco Azul')
        expect(page).to have_content('4,0%')
        expect(page).to have_content('30')
        expect(page).to have_css('img[src*="banco-placeholder.png"]')
    end
end