# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admins = JSON.parse(File.read(Rails.root.join('public/data/admin.json')))
admins.each do |admin| 
  User.create!(admin)
end

users = JSON.parse(File.read(Rails.root.join('public/data/users.json')))
users.each do |user|
  User.create!(user)
end

companies = JSON.parse(File.read(Rails.root.join('public/data/companies.json')))
companies.each do |company| 
  Company.create!(company)
end

employees = JSON.parse(File.read(Rails.root.join('public/data/employees.json')))
employees.each do |employee| 
  Employee.create!(employee)
end
cards = JSON.parse(File.read(Rails.root.join('public/data/creditcards.json')))
cards.each do |card| 
  CreditCard.create!(card)
end

boletos = JSON.parse(File.read(Rails.root.join('public/data/boletos.json')))
boletos.each do |boleto| 
  Boleto.create!(boleto)
end

pixes = JSON.parse(File.read(Rails.root.join('public/data/pixes.json')))
pixes.each do |pix| 
  Pix.create!(pix)
end

pm_company = JSON.parse(File.read(Rails.root.join('public/data/paymentcompany.json')))
pm_company.each do |pm| 
  PaymentMethodsCompany.create!(pm)
end

products = JSON.parse(File.read(Rails.root.join('public/data/products.json')))
products.each do |product|
  Product.create!(product)
end

customers = JSON.parse(File.read(Rails.root.join('public/data/customers.json')))
customers.each do |customer|
  Customer.create!(customer)
end

log_customers = JSON.parse(File.read(Rails.root.join('public/data/logcustomers.json')))
log_customers.each do |log| 
  LogCustomer.create!(log)
end
