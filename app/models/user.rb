class User < ApplicationRecord
  has_many :tasks
  before_create :encrypt_password

  validates :email, presence: :rue, 
                    uniqueness: true, 
                    format: { with: /[\w]+@([\w-]+\.)+[\w-]{2,4}/ }
  validates :password, presence:true,
                       confirmation: true
  validates :nickname, presence: true

  private
  def encrypt_password
    self.password = Digest::SHA1.hexdigest("aaa#{self.password}zzz")
  end
end
