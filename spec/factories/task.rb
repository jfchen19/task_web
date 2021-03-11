FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    subject { Faker::Lorem.paragraphs }
    start_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 3.days) }
    end_time { Faker::Time.between(from: DateTime.now + 3.days, to: DateTime.now + 10.days) }
    
    trait :start_time_after_end_time do
      start_time { Faker::Time.between(from: DateTime.now + 3.days, to: DateTime.now + 10.days) }
      end_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 3.days) }
    end
  end
end
