require 'rails_helper'

describe 'Users Manages their company' do
  it 'and first user is redirected to register it' do
    user = User.create!(name: 'John',
                        lastname: 'Doe',
                        email: 'johndoe@codeplay.com.br',
                        password: 12345678,
                        status: 0)

    login_as user, scope: :user
    visit root_path
    expect(page).to have_content("Registre sua Empresa")
  end

  it 'and register it successfully' do
    user = User.create!(name: 'John',
                        lastname: 'Doe',
                        email: 'johndoe@codeplay.com.br',
                        password: 12345678,
                        status: 0)

    login_as user, scope: :user
    visit root_path
    fill_in 'Razão Social', with: 'Codeplay'
    fill_in 'CNPJ', with: '68346575000102'
    fill_in 'Email de Faturamento', with: 'faturamento@codeplay.com.br'
    fill_in 'Endereço de Faturamento', with: 'Rua Endereço de teste, bairro de teste, numero 100, São Paulo'
    click_on 'Registrar Empresa'

    expect(page).to have_content('Empresa cadastrada com sucesso. Bem vindo a página da sua empresa.')

  end

  it 'and view company token' do
    company = Company.create!(name: 'Codeplay',
                              cnpj: 77418744000155,
                              billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
                              billing_email: 'genericemail@codeplay.com.br',
                              status: 0)
    user = User.create!(name: 'John',
                        lastname: 'Doe',
                        email: 'johndoe@codeplay.com.br',
                        password: '123456',
                        status: 0,
                        role: 5)

    Employee.create!(user: user, company: company)
    login_as user, scope: :user
    visit root_path
    click_on 'Ver Token da Empresa'

    expect(page).to have_content(company.token)
  end

end