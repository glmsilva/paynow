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
                    customer_cpf: '451.712.100-39',
                    address:'Avenida André Antônio Maggi, Jardim Maria Vindilina I,78553-000,340, Sinop, MT' 
                  }
          } 

        expect(response).to have_http_status(201)
        expect(response.content_type).to include('application/json')
        expect(response.body).to include("40")
        expect(response.body).to include('Jane Doe')
        expect(response.body).to include('pendente')
    end
  end
end