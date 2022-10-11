# frozen_string_literal: true

module Admin
  class ReviewPolicy < ApplicationPolicy
    def index?
      check_user_access
    end

    def show?
      check_user_access
    end

    def update?
      check_user_access
    end

    def destroy?
      check_user_access
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end

    private

    def check_user_access
      user.present? && user.admin? && user.check_reviews? if user
    end
  end
end
