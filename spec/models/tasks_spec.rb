require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "task data input" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :subject }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }

    it 'end time after end time' do
      task_with_valid_input = FactoryBot.build(:task)
      expect{task_with_valid_input.save}.to change{Task.count}.by(1)
    end

    it 'start time after end time' do
      task_with_invalid_input = FactoryBot.build(:task, :start_time_after_end_time)
      expect{task_with_invalid_input.save}.to change{task_with_invalid_input.errors.full_messages}.from([]).to(["#{I18n.t('activerecord.attributes.task.end_time')} #{I18n.t('activerecord.errors.models.task.attributes.end_time_after_start_time')}"])
    end
  end

  describe "task state transition" do
    let! (:task) { FactoryBot.create(:task) }

    it "original state" do
      expect(task).to have_state(:pending)
      expect(task).not_to have_state(:processing)
      expect(task).not_to have_state(:completed)
    end

    it "change state from pending to processing" do
      expect(task).to transition_from(:pending).to(:processing).on_event(:start)

      expect(task).to have_state(:processing)
      expect(task).not_to have_state(:pending)
      expect(task).not_to have_state(:completed)
    end

    it "change state from processing to completed" do
      expect(task).to transition_from(:processing).to(:completed).on_event(:complete)

      expect(task).to have_state(:completed)
      expect(task).not_to have_state(:processing)
      expect(task).not_to have_state(:pending)
    end
  end
end
