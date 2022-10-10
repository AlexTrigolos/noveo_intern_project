require 'csv'

class ExportBookingsCsvJob < ApplicationJob
  queue_as :default

  def perform(file_name)
    dir = File.dirname("#{Rails.root}/.files/my.log")
    FileUtils.mkdir_p(dir) unless File.directory?(dir)

    CSV.open(Rails.root.join(".files", file_name), 'w') do |csv_write|
      csv_write << ["ID", "user email", "user check-in", "user check-out", "number of people", "room id"]
      Admin::Booking.all.where(confirmed: :true).order(created_at: :desc).each do |booking|
        csv_write << [booking.id, booking.email, booking.check_in_date, booking.check_out_date, booking.number_people, booking.room_id]
      end
    end
    Admin::ConfirmedBookingsFile.create!(file: file_name)
  end
end