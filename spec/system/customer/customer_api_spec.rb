require 'rails_helper' 

describe 'Customer API' do 
  describe 'POST api/v1/customer/' do 
    it 'create a customer bind to a company' do 
      company = Company.create!(name: 'Codeplay',
        cnpj: 77418744000155,
        billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
        billing_email: 'genericemail@codeplay.com.br',
        status: 0)
      token = Digest::MD5.hexdigest 'Jane Doe451.712.100-39'
      post '/api/v1/customers', params: {
        customer: {company_token: company.token, name: 'Jane Doe', cpf: '451.712.100-39'}
      }


      expect(response).to have_http_status(201)
      expect(response.content_type).to include("application/json")
      expect(response.body).to include(token[0,20])
    end

    it 'and bind an existing customer to another company' do 
      company = Company.create!(name: 'Codeplay',
        cnpj: 77418744000155,
        billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
        billing_email: 'genericemail@codeplay.com.br',
        status: 0)
      company2 = Company.create!(name: 'Nigthchoose',
        cnpj: 77418744000155,
        billing_address: 'Rua 1, Bairro 2, nº 123, São Paulo',
        billing_email: 'genericemail@nightchoose.com.br',
        status: 0)
      token = Digest::MD5.hexdigest 'Jane Doe451.712.100-39'
      Customer.create!(token: token[0,20])
      LogCustomer.create!(customer_token: token[0,20], company: company2)
      
      post '/api/v1/customers', params: {
        customer: {company_token: company2.token, name: 'Jane Doe', cpf: '451.712.100-39'}
      }

      expect(response).to have_http_status(202)
      expect(response.content_type).to include("application/json")
      expect(response.body).to include(token[0,20])

    end
  end
end