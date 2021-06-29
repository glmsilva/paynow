require 'rails_helper' 

describe 'Admin manages customer' do 
    it 'and view customers link' do 

    User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)

    visit root_path
    click_on 'Login'
    click_on 'Entrar'

    fill_in 'Email', with: 'johndoe@paynow.com.br'
    fill_in 'Senha', with: 'ec1@eR0r'
    find(:css, ".actions .login").click

    expect(page).to have_content('Bem vindo, John Doe')
    expect(page).to have_content('Paynow Admin')
    expect(page).to have_content('Clientes')

    end

    it 'and visit blank customers page' do 
        user = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)

        login_as user, scope: :user
        visit admin_index_path
        click_on 'Clientes'

        expect(current_path).to eq(admin_companies_path)
        expect(page).to have_content('Nenhum cliente cadastrado')
    end

    it 'and visit customers page' do 
        user = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        company = Company.create!(name: 'Codeplay',
            cnpj: '77418744000155',
            billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
            billing_email: 'genericemail@codeplay.com.br',
            status: 0)

        user2 = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user2, company: company)

        login_as user, scope: :user
        visit admin_index_path
        click_on 'Clientes'

        expect(current_path).to eq(admin_companies_path)
        expect(page).to have_content('Codeplay')
        expect(page).to have_content('77418744000155')
        expect(page).to have_content('Rua 1, Bairro 2, nº 123, São Paulo')
        expect(page).to have_content('genericemail@codeplay.com.br')
        expect(page).to have_content('Ativo')
    end

    it 'and edit a customer' do 
        user = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        company = Company.create!(name: 'cooodeplay',
            cnpj: '77418744000155',
            billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
            billing_email: 'genericemail@codeplay.com.br',
            status: 0)

        user2 = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user2, company: company)

        login_as user, scope: :user
        visit admin_index_path
        click_on 'Clientes'
        click_on 'Editar'
        fill_in 'Nome', with: 'Codeplay'
        click_on 'Salvar'

        expect(page).to have_content('Cliente atualizado com sucesso')
        expect(page).to have_content('Codeplay')
    end

    it 'and return without edit' do 
        user = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        company = Company.create!(name: 'cooodeplay',
            cnpj: '77418744000155',
            billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
            billing_email: 'genericemail@codeplay.com.br',
            status: 0)

        user2 = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user2, company: company)

        login_as user, scope: :user
        visit admin_index_path
        click_on 'Clientes'
        click_on 'Editar'
        click_on 'Voltar'

        expect(current_path).to eq(admin_companies_path)
    end

    it 'should not inactivate without confirmation from another admin' do
        admin1 = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        admin2 = User.create!(email: 'bwayne@paynow.com.br', password: 'ec1@eR0r', name: 'Bruce', lastname: 'Wayne', role: 10)
        company = Company.create!(name: 'coodeplay',
            cnpj: '77418744000155',
            billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
            billing_email: 'genericemail@codeplay.com.br',
            status: 0)

        user = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user, company: company)

        login_as admin2, scope: :user
        visit admin_index_path
        click_on 'Clientes'
        click_on 'Editar'
        click_on 'Inativar'

        expect(page).to have_content('Cliente em pendência para ser inativado')

    end

    it 'and inactivate a customer' do 
        admin1 = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        admin2 = User.create!(email: 'bwayne@paynow.com.br', password: 'ec1@eR0r', name: 'Bruce', lastname: 'Wayne', role: 10)
        company = Company.create!(name: 'coodeplay',
            cnpj: '77418744000155',
            billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
            billing_email: 'genericemail@codeplay.com.br',
            status: 0)

        user = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user, company: company)
        LogCompaniesChange.create!(user: admin1, company: company, status: 1, category: 1)

        login_as admin2, scope: :user
        visit admin_index_path
        click_on 'Clientes'
        click_on 'Editar'
        click_on 'Inativar'

        expect(page).to have_content('Ativar')
        expect(page).to have_content('Cliente inativado com sucesso')
    end

    it 'and try to inactivate a customer' do 
        admin1 = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        company = Company.create!(name: 'coodeplay',
            cnpj: '77418744000155',
            billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
            billing_email: 'genericemail@codeplay.com.br',
            status: 0)

        user = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user, company: company)
        LogCompaniesChange.create!(user: admin1, company: company, status: 1, category: 1)

        login_as admin1, scope: :user
        visit admin_index_path
        click_on 'Clientes'
        click_on 'Editar'
        click_on 'Inativar'

        expect(page).to have_content('Inativar')
        expect(page).to have_content('Desculpe, você não tem autorização para fazer isso')
    end

    it 'and activate a customer' do 
        admin1 = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        admin2 = User.create!(email: 'bwayne@paynow.com.br', password: 'ec1@eR0r', name: 'Bruce', lastname: 'Wayne', role: 10)
        company = Company.create!(name: 'coodeplay',
            cnpj: '77418744000155',
            billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
            billing_email: 'genericemail@codeplay.com.br',
            status: 1)

        user = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user, company: company)
        LogCompaniesChange.create!(user: admin1, company: company, status: 0, category: 1)

        login_as admin2, scope: :user
        visit admin_index_path
        click_on 'Clientes'
        click_on 'Ver Inativos'
        click_on 'Editar'
        click_on 'Ativar'

        expect(page).to have_content('Inativar')
        expect(page).to have_content('Cliente reativado com sucesso')
    end    
    it 'and return to companies page' do 
        user = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        company = Company.create!(name: 'cooodeplay',
            cnpj: '77418744000155',
            billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
            billing_email: 'genericemail@codeplay.com.br',
            status: 0)

        user2 = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user2, company: company)

        login_as user, scope: :user
        visit admin_index_path
        click_on 'Clientes'
        click_on 'Editar'
        fill_in 'Nome', with: 'Codeplay'
        fill_in 'Cnpj', with: '66529855111266'
        click_on 'Salvar'
        click_on 'Voltar'

        expect(page).to have_content('Codeplay')
    end

    it 'and change company token from companies page' do 
        user = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        company = Company.create!(name: 'cooodeplay',
            cnpj: '77418744000155',
            billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
            billing_email: 'genericemail@codeplay.com.br',
            status: 0)

        user2 = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user2, company: company)
        company_token = company.token.to_s

        login_as user, scope: :user
        visit admin_index_path
        click_on 'Clientes'
        click_on 'Alterar Token'

        expect(page).not_to have_content(company_token)
    end

    it "and change company token from it's page" do 
        user = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        company = Company.create!(name: 'Codeplay',
            cnpj: '77418744000155',
            billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
            billing_email: 'genericemail@codeplay.com.br',
            status: 0)

        user2 = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user2, company: company)
        company_token = company.token.to_s

        login_as user, scope: :user
        visit admin_index_path
        click_on 'Clientes'
        click_on 'Codeplay'
        click_on 'Alterar Token'

        expect(page).not_to have_content(company_token)
    end
end