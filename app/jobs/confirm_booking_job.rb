# frozen_string_literal: true

class ConfirmBookingJob < ApplicationJob
  queue_as :default

  def perform(email)
    ConfirmBookingMailer.with(email: email).notice_confirm.deliver_now
  end
end
