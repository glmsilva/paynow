require 'rails_helper'

describe PaymentMethod, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      payment_method = PaymentMethod.new
      payment_method.valid?

      expect(payment_method.errors[:name]).to include('não pode ficar em branco')
      expect(payment_method.errors[:maxfee]).to include('não pode ficar em branco')
      expect(payment_method.errors[:chargefee]).to include('não pode ficar em branco')

    end
  end
end

