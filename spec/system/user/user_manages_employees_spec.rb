require 'rails_helper'

describe 'User manages employees' do 
  it 'should view employees link' do 
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

    expect(page).to have_link('Colaboradores')
  end

  it 'and view employees list' do 
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
    user2 = User.create!(name: 'Jane',
                 lastname: 'Doe',
                 email: 'janedoe@codeplay.com.br',
                 password: '123456',
                 status: 0,
                 role: 0)      
    user3 = User.create!(name: 'Klark',
                lastname: 'Kent',
                email: 'kkent@codeplay.com.br',
                password: '123456',
                status: 0,
                role: 0)
    
    Employee.create!(user: user, company: company)
    Employee.create!(user: user2, company: company)
    Employee.create!(user: user3, company: company)
    login_as user, scope: :user

    visit root_path 
    click_on 'Colaboradores'

    expect(page).to have_content('Jane Doe')
    expect(page).to have_content('Klark Kent')
  end
end