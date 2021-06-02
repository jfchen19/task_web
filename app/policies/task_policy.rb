class TaskPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  class Scope < Scope
    attr_reader :user, :task

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.present?
        scope.where(user: user)
      else
        scope.all
      end
    end
  end
end
