require 'rails_helper'

describe 'User update products' do 
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
    Product.create!(name: 'Sapato', price: 10, boleto: 5, credit: 5, pix: 10, company: company, status: 0)

    login_as user, scope: :user
    visit root_path
    click_on 'Produtos'
    click_on 'Editar'
    fill_in 'Nome', with: 'Tênis'
    fill_in 'Preço', with: 200
    fill_in 'Boleto', with: 20 
    fill_in 'Cartão de Crédito', with: 10
    fill_in 'Pix', with: 50
    click_on 'Salvar'

    expect(page).to have_content('Tênis')
  end
end