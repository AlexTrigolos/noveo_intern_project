# frozen_string_literal: true

class ConfirmBookingMailer < ApplicationMailer
  default from: ENV.fetch('MAILER_USER', nil)

  def notice_confirm
    mail to: params[:email], subject: t('.confirm_booking')
  end

  def notice_not_confirm
    mail to: params[:email], subject: t('.not_confirm_booking')
  end
end
