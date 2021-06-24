require 'rails_helper'

describe EmailValidator, type: :model do
  it 'could not registrate with a public email' do 
    email = "johndoe@gmail.com"
    user = User.new(email: email)
    user.save

    expect(user.errors[:email]).to include('é inválido')
  end
end
