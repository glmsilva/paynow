require 'rails_helper'

describe 'Update charges via api' do 
  context 'PUT api/v1/charges' do 
    it 'and should accept a charge successfully' do 
      admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
      CreditCard.create!(name: 'MasterCard',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/Mastercard-Logo.png')))
      company = Company.create!(name: 'Codeplay',
                                cnpj: '77418744000155',
                                billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
                                billing_email: 'genericemail@codeplay.com.br',
                                status: 0)
      user2 = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
      Employee.create!(user: user2, company: company)
      payment_method = CreditCardCompany.create!(company: company, payment_method: CreditCard.last, code: "123456", status: 0)
      token = Digest::MD5.hexdigest 'Jane Doe45171210039'
      Customer.create!(token: token[0,20])
      LogCustomer.create!(customer_token: token[0,20], company: company)
      product = Product.create!(name: "Fone de Ouvido",
                      price: 20.97,
                      boleto: 10,
                      credit: 5,
                      pix: 20,
                      company: company)
      charge = Charge.create!(company_token: company.token, 
        product_token: product.token,
        payment_method: "MasterCard", 
        customer_name: "Jane Doe", 
        customer_cpf: "45171210039", 
        card_number:"5386347583820863", 
        card_name: "Jane J Doe", 
        verification_code: "969", 
        regular_price: 20.97, 
        discount_price: 16.7,
        due_date: 1.month.from_now)

        put '/api/v1/charges/', params: {
          charge: { 
            token: charge.token,
            status: 5
          }

        }

        expect(response).to have_http_status(202)
        expect(response.content_type).to include("application/json")
        expect(response.body).to include('approved')
    end

    it 'and should reject a charge' do
        admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        CreditCard.create!(name: 'MasterCard',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/Mastercard-Logo.png')))
        company = Company.create!(name: 'Codeplay',
                                  cnpj: '77418744000155',
                                  billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
                                  billing_email: 'genericemail@codeplay.com.br',
                                  status: 0)
        user2 = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user2, company: company)
        payment_method = CreditCardCompany.create!(company: company, payment_method: CreditCard.last, code: "123456", status: 0)
        token = Digest::MD5.hexdigest 'Jane Doe45171210039'
        Customer.create!(token: token[0,20])
        LogCustomer.create!(customer_token: token[0,20], company: company)
        product = Product.create!(name: "Fone de Ouvido",
                        price: 20.97,
                        boleto: 10,
                        credit: 5,
                        pix: 20,
                        company: company)
        charge = Charge.create!(company_token: company.token, 
          product_token: product.token,
          payment_method: "MasterCard", 
          customer_name: "Jane Doe", 
          customer_cpf: "45171210039", 
          card_number:"5386347583820863", 
          card_name: "Jane J Doe", 
          verification_code: "969", 
          regular_price: 20.97, 
          discount_price: 16.7,
          due_date: 1.month.from_now)
  
          put '/api/v1/charges/', params: {
            charge: { 
              token: charge.token,
              status: 11
            }
  
          }
  
          expect(response).to have_http_status(202)
          expect(response.content_type).to include("application/json")
          expect(response.body).to include('refused')
          expect(response.body).to include('pending')
    end
  end

  context 'GET api/v1/charges' do 
    it 'and should filter by due date' do 
      admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        CreditCard.create!(name: 'MasterCard',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/Mastercard-Logo.png')))
        company = Company.create!(name: 'Codeplay',
                                  cnpj: '77418744000155',
                                  billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
                                  billing_email: 'genericemail@codeplay.com.br',
                                  status: 0)
        user2 = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user2, company: company)
        payment_method = CreditCardCompany.create!(company: company, payment_method: CreditCard.last, code: "123456", status: 0)
        token = Digest::MD5.hexdigest 'Jane Doe45171210039'
        Customer.create!(token: token[0,20])
        LogCustomer.create!(customer_token: token[0,20], company: company)
        product = Product.create!(name: "Fone de Ouvido",
                        price: 20.97,
                        boleto: 10,
                        credit: 5,
                        pix: 20,
                        company: company)
        charge = Charge.create!(company_token: company.token, 
          product_token: product.token,
          payment_method: "MasterCard", 
          customer_name: "Jane Doe", 
          customer_cpf: "45171210039", 
          card_number:"5386347583820863", 
          card_name: "Jane J Doe", 
          verification_code: "969", 
          regular_price: 20.97, 
          discount_price: 16.7,
          due_date: 1.month.from_now)
  
          get '/api/v1/charges/', params: {
            charge: { 
              due_date: 1.month.from_now
            }
  
          }
  
          expect(response).to have_http_status(202)
          expect(response.content_type).to include("application/json")
          expect(response.body).to include(1.month.from_now.strftime('%Y-%m-%d'))
          expect(response.body).to include('pending')


    end

    it 'and should filter by payment method' do 
      admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        CreditCard.create!(name: 'MasterCard',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/Mastercard-Logo.png')))
        company = Company.create!(name: 'Codeplay',
                                  cnpj: '77418744000155',
                                  billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
                                  billing_email: 'genericemail@codeplay.com.br',
                                  status: 0)
        user2 = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user2, company: company)
        payment_method = CreditCardCompany.create!(company: company, payment_method: CreditCard.last, code: "123456", status: 0)
        token = Digest::MD5.hexdigest 'Jane Doe45171210039'
        Customer.create!(token: token[0,20])
        LogCustomer.create!(customer_token: token[0,20], company: company)
        product = Product.create!(name: "Fone de Ouvido",
                        price: 20.97,
                        boleto: 10,
                        credit: 5,
                        pix: 20,
                        company: company)
        charge = Charge.create!(company_token: company.token, 
          product_token: product.token,
          payment_method: "MasterCard", 
          customer_name: "Jane Doe", 
          customer_cpf: "45171210039", 
          card_number:"5386347583820863", 
          card_name: "Jane J Doe", 
          verification_code: "969", 
          regular_price: 20.97, 
          discount_price: 16.7,
          due_date: 1.month.from_now)
  
          get '/api/v1/charges/', params: {
            charge: { 
              payment_method: "MasterCard"
            }
  
          }
  
          expect(response).to have_http_status(202)
          expect(response.content_type).to include("application/json")
          expect(response.body).to include('MasterCard')
          expect(response.body).to include('pending')
    end

    it 'and should filter by both' do 
      admin = User.create!(email: 'johndoe@paynow.com.br', password: 'ec1@eR0r', name: 'John', lastname: 'Doe', role: 10)
        CreditCard.create!(name: 'MasterCard',chargefee: 10, maxfee: 50, icon: fixture_file_upload(Rails.root.join('spec/fixtures/Mastercard-Logo.png')))
        company = Company.create!(name: 'Codeplay',
                                  cnpj: '77418744000155',
                                  billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
                                  billing_email: 'genericemail@codeplay.com.br',
                                  status: 0)
        user2 = User.create!(email: 'janedoe@codeplay.com.br', password: 'ec1@eR0r', name: 'Jane', lastname: 'Doe', role: 10)
        Employee.create!(user: user2, company: company)
        payment_method = CreditCardCompany.create!(company: company, payment_method: CreditCard.last, code: "123456", status: 0)
        token = Digest::MD5.hexdigest 'Jane Doe45171210039'
        Customer.create!(token: token[0,20])
        LogCustomer.create!(customer_token: token[0,20], company: company)
        product = Product.create!(name: "Fone de Ouvido",
                        price: 20.97,
                        boleto: 10,
                        credit: 5,
                        pix: 20,
                        company: company)
        charge = Charge.create!(company_token: company.token, 
          product_token: product.token,
          payment_method: "MasterCard", 
          customer_name: "Jane Doe", 
          customer_cpf: "45171210039", 
          card_number:"5386347583820863", 
          card_name: "Jane J Doe", 
          verification_code: "969", 
          regular_price: 20.97, 
          discount_price: 16.7,
          due_date: 1.month.from_now)
  
          get '/api/v1/charges/', params: {
            charge: { 
              due_date: 1.month.from_now,
              payment_method: 'MasterCard'
            }
  
          }
  
          expect(response).to have_http_status(202)
          expect(response.content_type).to include("application/json")
          expect(response.body).to include(1.month.from_now.strftime('%Y-%m-%d'))
          expect(response.body).to include('MasterCard')
          expect(response.body).to include('pending')


    end
  end
end