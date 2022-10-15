# frozen_string_literal: true

class NotConfirmBookingJob < ApplicationJob
  queue_as :default

  def perform(email)
    ConfirmBookingMailer.with(email: email).notice_not_confirm.deliver_now
  end
end
