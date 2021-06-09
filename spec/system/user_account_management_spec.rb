require 'rails_helper'

describe 'User account management' do
  it 'unable registration with public email domains' do
    visit root_path
    click_on 'Registrar-se'

    fill_in 'Nome', with: 'John'
    fill_in 'Sobrenome', with: 'Doe'
    fill_in 'Email', with: 'johndoe@outlook.com.br'
    fill_in 'Senha', with: 'ec1@eR0r'
    fill_in 'Confirmar Senha', with: 'ec1@eR0r'
    click_on 'Registrar'

    expect(page).to have_content('Email é inválido')
  end

  it 'first user has to registrate their company' do
    visit root_path
    click_on 'Registrar-se'

    fill_in 'Nome', with: 'John'
    fill_in 'Sobrenome', with: 'Doe'
    fill_in 'Email', with: 'johndoe@codeplay.com.br'
    fill_in 'Senha', with: 'ec1@eR0r'
    fill_in 'Confirmar Senha', with: 'ec1@eR0r'
    click_on 'Registrar'
    expect(page).to have_content("Registre sua Empresa")

    expect(current_path).to eq(new_employees_company_path)

  end

  it 'user has redirected to your company page' do
    Company.create!(name: 'Codeplay',
                    cnpj: 77418744000155,
                    billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
                    billing_email: 'genericemail@codeplay.com.br',
                    status: 0)

    visit root_path
    click_on 'Registrar-se'

    fill_in 'Nome', with: 'John'
    fill_in 'Sobrenome', with: 'Doe'
    fill_in 'Email', with: 'johndoe@codeplay.com.br'
    fill_in 'Senha', with: 'ec1@eR0r'
    fill_in 'Confirmar Senha', with: 'ec1@eR0r'
    click_on 'Registrar'

    expect(page).to have_content("Bem vindo, John Doe")
    expect(page).to have_content('johndoe@codeplay.com.br')
    expect(current_path).to eq(employees_index_path)
  end
end