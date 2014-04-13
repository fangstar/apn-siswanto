# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :registry do 
    first_name          { Faker::Name.first_name }
    last_name           { Faker::Name.last_name }
    dealer_account      { [:gold, :silver, :platinum].sample }
    dealer_store        { "Dealer " + Faker::Company.name }
    region              { "Region " + Faker::Address.state }
    territory           { "Teritory " + Faker::Address.country }
    flagship            { [true, false].sample }
    purchase_date       { Time.now + ((-5..-1).to_a.sample.days) }
    registered_date     { Time.now + ((-10..-6).to_a.sample.days) }
    products            do
      ar = []
      rand(10).times{ 
        pinfo = {}
        pinfo[:model]   = Faker::Commerce.product_name
        pinfo[:serial]  = 'serial for ' + Faker::Commerce.product_name
        ar << pinfo
      }
      ar
    end 
  end
end
