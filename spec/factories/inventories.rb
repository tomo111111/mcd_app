FactoryBot.define do
  factory :inventory do
    order {10.55}
    use   {6.33}
    stock {4.7}
    date  {"2020-10-01"}
    association :item
    association :user
  end
end
