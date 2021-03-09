FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    subject { Faker::Lorem.paragraphs }
    start_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 3) }
    end_time { Faker::Time.between(from: DateTime.now + 3, to: DateTime.now + 10) }
  end
end
