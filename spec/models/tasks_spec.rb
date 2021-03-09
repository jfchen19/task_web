require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "task data input" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :subject }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }

    it 'end time after end time' do
      task_with_valid_input = Task.new(
                                title: Faker::Lorem.sentence,
                                subject: Faker::Lorem.paragraphs,
                                start_time: DateTime.now,
                                end_time: DateTime.now + 1
                              )
      expect{task_with_valid_input.save}.to change{Task.count}.by(1)
    end

    it 'start time after end time' do
      task_with_invalid_input = Task.new(
                                  title: Faker::Lorem.sentence,
                                  subject: Faker::Lorem.paragraphs,
                                  start_time: DateTime.now,
                                  end_time: DateTime.now - 1
                                )
      expect{task_with_invalid_input.save}.to change{task_with_invalid_input.errors.full_messages}.from([]).to(["#{I18n.t('activerecord.attributes.task.end_time')} #{I18n.t('activerecord.errors.models.task.attributes.end_time_after_start_time')}"])
    end
  end
end
