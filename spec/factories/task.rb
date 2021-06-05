FactoryBot.define do
  factory :task do
    user
    title { Faker::Lorem.sentence }
    subject { Faker::Lorem.paragraphs }
    priority { rand(0..2) }
    start_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 3.days) }
    end_time { Faker::Time.between(from: DateTime.now + 3.days, to: DateTime.now + 10.days) }
    
    trait :start_time_after_end_time do
      start_time { Faker::Time.between(from: DateTime.now + 3.days, to: DateTime.now + 10.days) }
      end_time { Faker::Time.between(from: DateTime.now, to: DateTime.now + 3.days) }
    end
  end
end
