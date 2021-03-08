class Task < ApplicationRecord
  validates :title, :subject, :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  scope :with_order, -> (order) { order(created_at: order) if order}

  def end_time_after_start_time
    if end_time < start_time
      errors.add(:end_time, "不能比開始時間早！")
    end
  end
end
