class PostPolicy < ApplicationPolicy
  def create?
    user.author?
  end

  def update?
    user.author? && record.user == user
  end

  def destroy?
    user.author? && record.user == user
  end

  def like?
    user.reader? || user.author?
  end

  def comment?
    user.reader? || user.author?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
