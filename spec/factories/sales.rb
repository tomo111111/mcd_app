FactoryBot.define do
  factory :sale do
    plan  {1000000}
    actual{900000}
    date  {"2020-10-20"}
    association :user
  end
end
