require 'rails_helper' 

describe 'User API' do 
  context 'POST api/v1/charges' do 
    it 'issue boleto charges' do 
      company = Company.create!(name: 'Codeplay',
        cnpj: 77418744000155,
        billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
        billing_email: 'genericemail@codeplay.com.br',
        status: 0)
        token = Digest::MD5.hexdigest 'Jane Doe451.712.100-39'
        Customer.create!(token: token[0,20])
        LogCustomer.create!(customer_token: token[0,20], company: company)
        product = Product.create!(name: 'Curso de Web', price: 40, boleto: 10, pix: 15, credit: 5, company: company)
        Boleto.create!(name: 'Boleto Banco Laranja',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))
        payment_method = BoletoCompany.create!(company: company, payment_method: Boleto.first, bank_code: '479', branch_code: '123', bank_account: '000123456', status: 0)

        post '/api/v1/charges', params: { 
          charge: { company_token: company.token, 
                    product_token: product.token, 
                    payment_method: 'boleto', 
                    customer_name: 'Jane Doe', 
                    customer_cpf: '45171210039',
                    address:'Avenida André Antônio Maggi, Jardim Maria Vindilina I,78553-000,340, Sinop, MT' 
                  }
          } 

        expect(response).to have_http_status(201)
        expect(response.content_type).to include('application/json')
        expect(response.body).to include("40")
        expect(response.body).to include('Jane Doe')
        expect(response.body).to include('pending')
    end

    it 'issue credit card charges' do 
        company = Company.create!(name: 'Codeplay',
          cnpj: 77418744000155,
          billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
          billing_email: 'genericemail@codeplay.com.br',
          status: 0)
          token = Digest::MD5.hexdigest 'Jane Doe451.712.100-39'
          Customer.create!(token: token[0,20])
          LogCustomer.create!(customer_token: token[0,20], company: company)
          product = Product.create!(name: 'Curso de Web', price: 40, boleto: 10, pix: 15, credit: 5, company: company)
          CreditCard.create!(name: 'MasterCard',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/Mastercard-Logo.png')))
          payment_method = CreditCardCompany.create!(company: company, payment_method: CreditCard.first,code: 473, status: 0)
  
          post '/api/v1/charges', params: { 
            charge: { company_token: company.token, 
                      product_token: product.token, 
                      payment_method: 'credit', 
                      customer_name: 'Jane Doe', 
                      customer_cpf: '45171210039',
                      card_number: '5386347583820863',
                      card_name: 'Jane J Doe',
                      verification_code: '969'
                    }
            } 
  
          expect(response).to have_http_status(201)
          expect(response.content_type).to include('application/json')
          expect(response.body).to include("40")
          expect(response.body).to include('Jane Doe')
          expect(response.body).to include('pending')
    end

    it 'issue pix charges' do 
      company = Company.create!(name: 'Codeplay',
        cnpj: 77418744000155,
        billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
        billing_email: 'genericemail@codeplay.com.br',
        status: 0)
        token = Digest::MD5.hexdigest 'Jane Doe451.712.100-39'
        Customer.create!(token: token[0,20])
        LogCustomer.create!(customer_token: token[0,20], company: company)
        product = Product.create!(name: 'Curso de Web', price: 40, boleto: 10, pix: 15, credit: 5, company: company)
        Pix.create!(name: 'Pix Banco Azul',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))
        payment_method = PixCompany.create!(company: company, payment_method: Pix.first, bank_code: '479',code: 'A$h3K3T6H1M69A$h3K3T6H1M69', status: 0)

        post '/api/v1/charges', params: { 
          charge: { company_token: company.token, 
                    product_token: product.token, 
                    payment_method: 'credit', 
                    customer_name: 'Jane Doe', 
                    customer_cpf: '45171210039'
                  }
          } 

        expect(response).to have_http_status(201)
        expect(response.content_type).to include('application/json')
        expect(response.body).to include("40")
        expect(response.body).to include('Jane Doe')
        expect(response.body).to include('pending')
    end

    it 'and no payment method inserted' do 
      company = Company.create!(name: 'Codeplay',
        cnpj: 77418744000155,
        billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
        billing_email: 'genericemail@codeplay.com.br',
        status: 0)
        token = Digest::MD5.hexdigest 'Jane Doe451.712.100-39'
        Customer.create!(token: token[0,20])
        LogCustomer.create!(customer_token: token[0,20], company: company)
        product = Product.create!(name: 'Curso de Web', price: 40, boleto: 10, pix: 15, credit: 5, company: company)
        Pix.create!(name: 'Pix Banco Azul',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))
        payment_method = PixCompany.create!(company: company, payment_method: Pix.first, bank_code: '479',code: 'A$h3K3T6H1M69A$h3K3T6H1M69', status: 0)

        post '/api/v1/charges', params: { 
          charge: { company_token: company.token, 
                    product_token: product.token,  
                    customer_name: 'Jane Doe', 
                    customer_cpf: '45171210039'
                  }
          }

        expect(response).to have_http_status(422)
        expect(response.content_type).to include('application/json')
        expect(response.body).to include("não pode ficar em branco")
    end
    
    it 'and two product tokens' do 
      company = Company.create!(name: 'Codeplay',
        cnpj: 77418744000155,
        billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
        billing_email: 'genericemail@codeplay.com.br',
        status: 0)
        token = Digest::MD5.hexdigest 'Jane Doe451.712.100-39'
        Customer.create!(token: token[0,20])
        LogCustomer.create!(customer_token: token[0,20], company: company)
        product = Product.create!(name: 'Curso de Web', price: 40, boleto: 10, pix: 15, credit: 5, company: company)
        product2 = Product.create!(name: 'Curso de Mobile', price: 40, boleto: 10, pix: 15, credit: 5, company: company)

        Pix.create!(name: 'Pix Banco Azul',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))
        payment_method = PixCompany.create!(company: company, payment_method: Pix.first, bank_code: '479',code: 'A$h3K3T6H1M69A$h3K3T6H1M69', status: 0)

        post '/api/v1/charges', params: { 
          charge: { company_token: company.token, 
                    product_token: product.token, 
                    product_token: product2.token,
                    payment_method: 'credit', 
                    customer_name: 'Jane Doe', 
                    customer_cpf: '45171210039'
                  }
          } 

        expect(response).to have_http_status(201)
        expect(response.content_type).to include('application/json')
        expect(response.body).to include("40")
        expect(response.body).to include('Jane Doe')
        expect(response.body).to include('pending')
        expect(response.body).to include(product2.token)
        expect(response.body).not_to include(product.token)
    end

    it 'should not create a charge without product' do 
      company = Company.create!(name: 'Codeplay',
        cnpj: 77418744000155,
        billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
        billing_email: 'genericemail@codeplay.com.br',
        status: 0)
        token = Digest::MD5.hexdigest 'Jane Doe451.712.100-39'
        Customer.create!(token: token[0,20])
        LogCustomer.create!(customer_token: token[0,20], company: company)
        product = Product.create!(name: 'Curso de Web', price: 40, boleto: 10, pix: 15, credit: 5, company: company)
        Pix.create!(name: 'Pix Banco Azul',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))
        payment_method = PixCompany.create!(company: company, payment_method: Pix.first, bank_code: '479',code: 'A$h3K3T6H1M69A$h3K3T6H1M69', status: 0)

        post '/api/v1/charges', params: { company_token: company.token, 
          charge: { payment_method: 'credit', 
            customer_name: 'Jane Doe', 
            customer_cpf: '45171210039'}
          }

        expect(response).to have_http_status(404)
        expect(response.content_type).to include('application/json')
    end

    it 'should not create a charge with invalid params' do 
      company = Company.create!(name: 'Codeplay',
        cnpj: 77418744000155,
        billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
        billing_email: 'genericemail@codeplay.com.br',
        status: 0)
        token = Digest::MD5.hexdigest 'Jane Doe451.712.100-39'
        Customer.create!(token: token[0,20])
        LogCustomer.create!(customer_token: token[0,20], company: company)
        product = Product.create!(name: 'Curso de Web', price: 40, boleto: 10, pix: 15, credit: 5, company: company)
        Pix.create!(name: 'Pix Banco Azul',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))
        payment_method = PixCompany.create!(company: company, payment_method: Pix.first, bank_code: '479',code: 'A$h3K3T6H1M69A$h3K3T6H1M69', status: 0)

        post '/api/v1/charges', params: { 
          charge: { compra: 1,
            product_token: product.token,}
          }

        expect(response).to have_http_status(422)
        expect(response.content_type).to include('application/json')   
        expect(response.body).to include("não pode ficar em branco")
    end

    it 'should not create a charge without params' do 
      company = Company.create!(name: 'Codeplay',
        cnpj: 77418744000155,
        billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
        billing_email: 'genericemail@codeplay.com.br',
        status: 0)
        token = Digest::MD5.hexdigest 'Jane Doe451.712.100-39'
        Customer.create!(token: token[0,20])
        LogCustomer.create!(customer_token: token[0,20], company: company)
        product = Product.create!(name: 'Curso de Web', price: 40, boleto: 10, pix: 15, credit: 5, company: company)
        Pix.create!(name: 'Pix Banco Azul',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/banco-placeholder.png')))
        payment_method = PixCompany.create!(company: company, payment_method: Pix.first, bank_code: '479',code: 'A$h3K3T6H1M69A$h3K3T6H1M69', status: 0)

        post '/api/v1/charges'

        expect(response).to have_http_status(412)
        expect(response.content_type).to include('application/json')   
        expect(response.body).to include("parece que você não enviou nenhum parametro ou o valor é vazio, preencha e envie novamente.")
    end
  end
end