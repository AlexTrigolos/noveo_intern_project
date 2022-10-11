# frozen_string_literal: true

module Admin
  class ConfirmedBookingsFilePolicy < ApplicationPolicy
    def index?
      check_user_access
    end

    def download?
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
end
