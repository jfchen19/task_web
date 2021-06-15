class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy

  before_destroy :can_destroy?, prepend: true

  validates :email, presence: :rue, 
                    uniqueness: true, 
                    format: { with: /[\w]+@([\w-]+\.)+[\w-]{2,4}/ }
  validates :password, presence:true,
                       confirmation: true
  validates :nickname, presence: true

  private
  def can_destroy?
    if User.where(admin: true).count == 1
      self.errors.add(:base, I18n.t('activerecord.errors.models.user.attributes.last_admin'))
      throw :abort  # 中斷 call back
    end
  end
end
