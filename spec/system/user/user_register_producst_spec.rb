require 'rails_helper'

describe 'User Register Products' do
    it 'successfully' do
        company = Company.create!(name: 'Arkham',
                                  cnpj: 77418744000155,
                                  billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
                                  billing_email: 'genericemail@arkham.com.br',
                                  status: 0)
        user = User.create!(name: 'John',
                            lastname: 'Doe',
                            email: 'johndoe@arkham.com.br',
                            password: '123456',
                            status: 0,
                            role: 5)
        Employee.create!(user: user, company: company)

        login_as user, scope: :user
        visit root_path
        click_on 'Produtos'
        click_on 'Cadastrar Produto'
        fill_in 'Nome', with: 'Sapato'
        fill_in 'Preço', with: '100'
        fill_in 'Boleto', with: '10'
        fill_in 'Cartão de Crédito', with: '5'
        fill_in 'Pix', with: '15'
        click_on 'Cadastrar'

        expect(page).to have_content('Sapato')
        expect(page).to have_content('R$ 100')
        expect(page).to have_content('10,0%')
        expect(page).to have_content('15,0%')
        expect(page).to have_content('5,0%')
    end

    it 'and return to products page' do
      company = Company.create!(name: 'Arkham',
                                cnpj: 77418744000155,
                                billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
                                billing_email: 'genericemail@arkham.com.br',
                                status: 0)
      user = User.create!(name: 'John',
                          lastname: 'Doe',
                          email: 'johndoe@arkham.com.br',
                          password: '123456',
                          status: 0,
                          role: 5)
      Employee.create!(user: user, company: company)
      
      login_as user, scope: :user
      visit root_path
      click_on 'Produtos'
      click_on 'Cadastrar Produto'
      fill_in 'Nome', with: 'Sapato'
      fill_in 'Preço', with: '100'
      fill_in 'Boleto', with: '10'
      fill_in 'Cartão de Crédito', with: '5'
      fill_in 'Pix', with: '15'
      click_on 'Cadastrar'
      click_on 'Voltar'

      expect(current_path).to eq(employees_products_path)
    end
end