require 'rails_helper'

describe User, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      user = User.new
      user.valid?

      expect(user.errors[:name]).to include('não pode ficar em branco')
      expect(user.errors[:lastname]).to include('não pode ficar em branco')
      expect(user.errors[:email]).to include('não pode ficar em branco')
      expect(user.errors[:password]).to include('não pode ficar em branco')

    end

    it 'email must be uniq' do
      User.create!(name: 'John', lastname: 'Doe', password: 12345678, email: 'johndoe@paynow.com.br')
      user2 = User.new(email: 'johndoe@paynow.com.br')

      user2.valid?

      expect(user2.errors[:email]).to include('já está em uso')
    end
  end
end
