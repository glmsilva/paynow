require 'rails_helper' 

describe 'Visitor view receipt' do 
    it 'succesfully' do 
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
      Charge.create!(company_token: company.token, 
        product_token: product.token,
        payment_method: "MasterCard", 
        customer_name: "Jane Doe", 
        customer_cpf: "45171210039", 
        card_number:"5386347583820863", 
        card_name: "Jane J Doe", 
        verification_code: "969", 
        regular_price: 20.97, 
        discount_price: 16.7,
        status: 5,
        due_date: 1.month.from_now)
        Receipt.create!(due_date:1.month.from_now, effective_date: Date.today, charge: Charge.last )


      visit receipt_path(Receipt.last.slug)
      expect(page).to have_content('Efetivada')
      expect(page).to have_content(company.name)
      expect(page).to have_content(product.name)
      expect(page).to have_content('MasterCard')
      expect(page).to have_content('R$ 20,97')
      expect(page).to have_content('R$ 16,70')
      expect(page).to have_content(Receipt.last.due_date)
      expect(page).to have_content(Receipt.last.effective_date)
    end 
end