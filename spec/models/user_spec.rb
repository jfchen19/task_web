require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:tasks) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :nickname }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value("email123@addresse.com").for(:email) }
  end
end
