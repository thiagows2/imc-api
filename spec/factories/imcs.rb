FactoryBot.define do
  factory :imc do
    height { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
    weight { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
  end
end
