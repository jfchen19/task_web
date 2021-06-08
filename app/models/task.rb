class Task < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy

  validates :title, :subject, :start_time, :end_time, :priority, presence: true
  validates :title, uniqueness: {scope: :user_id}
  validate :end_time_after_start_time

  scope :search_task, -> (keyword) { where("title LIKE ? OR subject LIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword }
  scope :search_by_tag, -> (tag) { joins(:tags).where("tags.name LIKE ?", "%#{tag}%") if tag }
  scope :search_by_state, -> (state) { where(state: state) if state }

  enum priority: { low: 0, medium: 1, high: 2 }

  def self.sort_tasks(params)
    if params[:order_by_created_time]
      Task.order(created_at: params[:order_by_created_time])
    elsif params[:order_by_end_time]
      Task.order(end_time: params[:order_by_end_time])
    elsif params[:order_by_priority]
      Task.order(priority: params[:order_by_priority])
    else
      Task.order(created_at: :DESC) 
    end
  end

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, I18n.t('activerecord.errors.models.task.attributes.end_time_after_start_time'))
      # TODO 這裡的錯誤訊息用英文寫死，翻譯的話到 view 再翻譯
    end
  end

  # Getter
  def tag_list
    tags.map{ |t| t.name }.join(',')
  end

  # Setter
  def tag_list=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create  # first_or_create：如果沒有的話就建立並存入資料庫
    end
  end
end
