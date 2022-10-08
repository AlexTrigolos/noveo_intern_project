class Admin::BookingPolicy < ApplicationPolicy

  def index?
    check_user_access
  end

  def new?
    check_user_access
  end

  def create?
    check_user_access
  end

  def show?
    check_user_access
  end

  def edit?
    check_user_access
  end

  def update?
    check_user_access
  end

  def destroy?
    check_user_access
  end

  def confirmed_bookings?
    check_user_access
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def check_user_access
    user.present? && user.admin? && user.confirms_reservations? if user
  end
end
