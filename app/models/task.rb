class Task < ApplicationRecord
  validates :title, presence: true
  validates :subject, presence: true
  
  scope :find_order, -> (order) {
    if order.present?
      case order
      when "asc"
        @tasks = Task.all.order(created_at: :asc)
      when "desc"
        @tasks = Task.all.order(created_at: :desc)
      end
    else
      @tasks = Task.all
    end
  }
end
