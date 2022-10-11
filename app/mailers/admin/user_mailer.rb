# frozen_string_literal: true

module Admin
  class UserMailer < ApplicationMailer
    def export_bookings_zip
      @user = params[:user]
      stream = params[:stream]

      attachments['bookings.zip'] = stream.read
      mail to: @user.email, subject: t('.message')
    end
  end
end
