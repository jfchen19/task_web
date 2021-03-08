class Task < ApplicationRecord
  validates :title, presence: true
  validates :subject, presence: true

  scope :with_order, -> (order) { order(created_at: order) if order}
end
