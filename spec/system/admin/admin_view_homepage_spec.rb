require 'rails_helper'

describe 'Admin authentication' do
  it 'view register link' do
    visit root_path

    expect(page).to have_link('Registrar-se')
  end

  it 'with email and password' do
    visit root_path
    click_on 'Registrar-se'
    fill_in 'Nome', with: 'John'
    fill_in 'Sobrenome', with: 'Doe'
    fill_in 'Email', with: 'johndoe@paynow.com.br'
    fill_in 'Senha', with: 'ec1@eR0r'
    fill_in 'Confirmar Senha', with: 'ec1@eR0r'
    click_on 'Registrar'

    expect(page).to have_content('Login efetuado com sucesso')
  end

  it 'fields cannot be blank' do
   visit root_path
   click_on('Registrar-se')

   click_on('Registrar')

   expect(page).to have_content('não pode ficar em branco', count: 4)
  end

  it 'login succesfully' do
    User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)

    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'johndoe@paynow.com.br'
    fill_in 'Senha', with: 'ec1@eR0r'
    click_on 'Entrar'

    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_content('Bem vindo, John Doe')
    expect(current_path).to eq(admin_index_path)
  end

  it 'fields cannot be blank' do
    visit root_path
    click_on 'Entrar'
    click_on 'Entrar'

    expect(page).to have_content('Email ou senha inválida')
  end

  it 'and no account is registered' do
    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'johndoe@paynow.com.br'
    fill_in 'Senha', with: 'ec1@eR0r'
    click_on 'Entrar'

    expect(page).to have_content('Email ou senha inválida')
  end
end
