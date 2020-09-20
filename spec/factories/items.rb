FactoryBot.define do
  factory :item do
    name  {"おいしいパン"}
    margin{8}
    association :user
  end
end
