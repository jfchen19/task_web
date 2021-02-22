class Task < ApplicationRecord
  validates :title, presence: true
  validates :subject, presence: true
end
