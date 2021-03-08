class Task < ApplicationRecord
  validates :title, :subject, :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  scope :with_order, -> (order) { order(created_at: order) if order}

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, I18n.t('activerecord.errors.models.task.attributes.end_time_after_start_time'))
    end
  end
end
