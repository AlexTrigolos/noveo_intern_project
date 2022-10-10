class ExportBookingsZipService < ApplicationService
  def call
    renderer = ActionController::Base.new
    compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      Admin::Booking.all.where(confirmed: :true).order(created_at: :desc).each do |booking|
        zos.put_next_entry "booking_#{booking.id}.xlsx"
        zos.print renderer.render_to_string(layout: false, handlers: [:axlsx], formats: [:xlsx], template: 'admin/bookings/booking', locals: {booking: booking})
      end
    end
    compressed_filestream.rewind
    compressed_filestream
  end
end