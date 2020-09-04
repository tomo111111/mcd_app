FactoryBot.define do
  factory :user do
    store_name { 'みかん店' }
    store_number { '123456' }
    email { Faker::Internet.free_email }
    password = Faker::Internet.password(min_length: 8)
    password { password }
    password_confirmation { password }
  end
end
