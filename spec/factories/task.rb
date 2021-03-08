FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    subject { Faker::Lorem.paragraphs }
  end
end
