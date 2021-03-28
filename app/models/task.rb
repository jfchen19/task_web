class Task < ApplicationRecord
  validates :title, :subject, :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  scope :with_created_at, -> (param) { order(created_at: param) if param }
  scope :with_end_time, -> (param) { order(end_time: param) if param }
  scope :search_task, -> (keyword) { where("title LIKE ? OR subject LIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword }

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, I18n.t('activerecord.errors.models.task.attributes.end_time_after_start_time'))
      # TODO 這裡的錯誤訊息用英文寫死，翻譯的話到 view 再翻譯
    end
  end

  include AASM
  aasm column: :state, no_direct_assigment: true do
    state :pending, initial: true
    state :processing, :completed

    event :start do
      transitions from: :pending, to: :processing
    end

    event :complete do
      transitions from: :processing, to: :completed
    end
  end
end
