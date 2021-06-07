require 'rails_helper'

describe 'Admin authentication' do
  it 'view register link' do
    visit root_path

    expect(page).to have_link('Registrar-se')
  end

  it 'register on website' do
    visit root_path
    click_on('Registrar-se')

    fill_in 'Email', with: 'johndoe@paynow.com.br'
    fill_in 'Senha', with: 'ec1@eR0r'
    fill_in 'Confirmação de Senha', with: 'ec1@eR0r'
    fill_in 'Nome', with: 'John'
    fill_in 'Sobrenome', with: 'Doe'
    click_on('Registrar')

    expect(page).to have_content('Cadastro realizado com sucesso')
    expect(page).to have_content('Bem-vindo, John Doe')


  end

  it 'fields cannot be blank' do
   visit root_path
    click_on('Registrar-se')

    click_on('Registrar')

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  it 'login to website' do
    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: 'johndoe@paynow.com.br'
    fill_in 'Senha', with: 'ec1@eR0r'
    click_on 'Entrar'

    expect(page).to have_content('Login realizado com sucesso')
    expect(page).to have_content('Bem vindo, John Doe')
  end

  it 'fields cannot be blank' do
    visit root_path
    click_on 'Entrar'
    click_on 'Entrar'

    expect(page).to have_content('Senha é obrigatória')
  end

end
