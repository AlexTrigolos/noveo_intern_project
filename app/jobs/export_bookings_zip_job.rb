# frozen_string_literal: true

class ExportBookingsZipJob < ApplicationJob
  queue_as :default

  def perform(initiator)
    stream = ExportBookingsZipService.call

    Admin::UserMailer.with(user: initiator, stream: stream).export_bookings_zip.deliver_now
  end
end
