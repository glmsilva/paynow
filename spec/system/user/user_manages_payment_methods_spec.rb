require 'rails_helper'

describe 'User manages payment methods' do 
  it 'and view none payment methods available yet' do 
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
        click_on 'Métodos de Pagamento'

        expect(page).to have_content('Métodos de pagamento disponíveis:')
        expect(page).to have_content('Nenhum', count: 2)
        expect(page).to have_content('Métodos de pagamento cadastrados:')
    end

    it 'and view payment methods available' do 
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
        CreditCard.create!(name: 'PisaCard',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/pisacard.png')))
        Boleto.create!(name: 'Boleto Banco Vermelho',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/pisacard.png')))
        Pix.create!(name: 'Pix Banco Laranja',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))

        login_as user, scope: :user
        visit root_path
        click_on 'Métodos de Pagamento'

        expect(page).to have_content('PisaCard')
        expect(page).to have_content('10')
        expect(page).to have_content('50')
        expect(page).to have_css('img[src*="pisacard.png"]')
        expect(page).to have_content('Boleto Banco Vermelho')
        expect(page).to have_content('Pix Banco Laranja')
        expect(page).to have_css('img[src*="banco-placeholder.png"]')
    end

    it 'and view none payment methods available yet' do 
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
        click_on 'Métodos de Pagamento'
    
        expect(page).to have_content('Métodos de pagamento disponíveis:')
        expect(page).to have_content('Nenhum', count: 2)
        expect(page).to have_content('Métodos de pagamento cadastrados:')
    end

    it 'and create a credit card successfully' do 
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
        CreditCard.create!(name: 'PisaCard',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/pisacard.png')))
        
        login_as user, scope: :user
        visit root_path
        click_on 'Métodos de Pagamento'
        find(:css, ".CreditCard").click
        fill_in 'Código Alfanúmerico Operadora do Cartão', with: 'eF1C3r08qT379091'
        click_on 'Cadastrar Cartão'

        expect(page).to have_content('Método de Pagamento Cadastrado')
        expect(page).to have_content('PisaCard')
        expect(page).to have_link('Ver mais')
    end

    it 'and create a boleto successfully' do 
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
      Boleto.create!(name: 'Boleto Banco Laranja',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))
      
      login_as user, scope: :user
      visit root_path
      click_on 'Métodos de Pagamento'
      find(:css, ".Boleto").click
      fill_in 'Código do Banco', with: '479'
      fill_in 'Número da Agência', with: '0123'
      fill_in 'Número Conta Bancária', with: '000123456'
      click_on 'Cadastrar Boleto'
      
      expect(page).to have_content('Método de Pagamento Cadastrado')
      expect(page).to have_content('Boleto Banco Laranja')
      expect(page).to have_link('Ver mais')
    end

    it 'and create a pix successfully' do 
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
Pix.create!(name: 'Pix Banco Azul',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))

login_as user, scope: :user
visit root_path
click_on 'Métodos de Pagamento'
find(:css, ".Pix").click
fill_in 'Chave Pix', with: 'A$h3K3T6H1M69A$h3K3T6H1M69'
fill_in 'Código do Banco', with: '479'
click_on 'Cadastrar Pix'

expect(page).to have_content('Método de Pagamento Cadastrado')
expect(page).to have_content('Pix Banco Azul')
expect(page).to have_link('Ver mais')
    end

    it 'and inactivate a payment method' do 
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
          CreditCard.create!(name: 'PisaCard',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/pisacard.png')))

          login_as user, scope: :user
          visit root_path
          click_on 'Métodos de Pagamento'
          find(:css, ".CreditCard").click
          click_on 'Cadastrar Cartão'
          click_on 'Inativar'

          expect(page).to have_content('Inativado com sucesso')
          expect(page).to have_content('Nenhum')
    end

    it 'and view Boleto details' do 
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
        payment_method = Boleto.create!(name: 'Boleto Banco Laranja',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))
        BoletoCompany.create!(company: company, payment_method: payment_method, bank_code: '479', branch_code: '123', bank_account: '000123456', status: 0)

        login_as user, scope: :user
        visit root_path
        click_on 'Métodos de Pagamento'
        click_on 'Ver mais'

        expect(page).to have_content("Boleto Banco Laranja")
        expect(page).to have_content("10")
        expect(page).to have_content("50")
        expect(page).to have_content("Código do Banco:")
        expect(page).to have_content("479")
        expect(page).to have_content("Número da Agência:")
        expect(page).to have_content("123")
        expect(page).to have_content("Número da Conta:")
        expect(page).to have_content("123456")
    end

    it 'and view Credit Card details' do 
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
        payment_method = CreditCard.create!(name: 'MasterCard',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/Mastercard-Logo.png')))
        CreditCardCompany.create!(company: company, payment_method: payment_method, code: "123456", status: 0)

        login_as user, scope: :user
        visit root_path
        click_on 'Métodos de Pagamento'
        click_on 'Ver mais'

        expect(page).to have_content("MasterCard")
        expect(page).to have_content("10")
        expect(page).to have_content("50")
        expect(page).to have_content("Código:")
        expect(page).to have_content("123456")
      end
end