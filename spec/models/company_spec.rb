require 'rails_helper'

describe Company, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      company = Company.new
      company.valid?

      expect(company.errors[:name]).to include('não pode ficar em branco')
      expect(company.errors[:cnpj]).to include('não pode ficar em branco')
      expect(company.errors[:billing_address]).to include('não pode ficar em branco')
      expect(company.errors[:billing_email]).to include('não pode ficar em branco')

    end

    it 'cnpj must be 14 characters long' do 
      company = Company.new(cnpj: '123456789')
      company2 = Company.new(cnpj: '1234567891011121314')
      company.valid? 
      company2.valid?
      
      expect(company.errors[:cnpj]).to include('não possui o tamanho esperado (14 caracteres)')
      expect(company2.errors[:cnpj]).to include('não possui o tamanho esperado (14 caracteres)')
    end
  end
end
