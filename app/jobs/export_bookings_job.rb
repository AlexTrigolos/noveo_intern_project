class ExportBookingsJob < ApplicationJob
  queue_as :default

  def perform(initiator)
    stream = ExportBookingsService.call

    Admin::UserMailer.with(user: initiator, stream: stream).export_bookings.deliver_now
  end
end