class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  before_create :encrypt_password
  before_destroy :can_destroy?, prepend: true

  validates :email, presence: :rue, 
                    uniqueness: true, 
                    format: { with: /[\w]+@([\w-]+\.)+[\w-]{2,4}/ }
  validates :password, presence:true,
                       confirmation: true
  validates :nickname, presence: true

  def self.login(user)
    pw = Digest::SHA1.hexdigest("aaa#{user[:password]}zzz")
    User.find_by(email: user[:email], password: pw)
  end

  private
  def encrypt_password
    self.password = Digest::SHA1.hexdigest("aaa#{self.password}zzz")
  end

  def can_destroy?
    if User.where(admin: true).count == 1
      self.errors.add(:base, I18n.t('activerecord.errors.models.user.attributes.last_admin'))
      throw :abort  # 中斷 call back
    end
  end
end
