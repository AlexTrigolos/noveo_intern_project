# frozen_string_literal: true

module Admin
  class ConfirmedBookingsFilesController < ApplicationController
    # GET /admin/confirmed_bookings_files
    def index
      @admin_confirmed_bookings_files = Admin::ConfirmedBookingsFile.all.order(created_at: :desc)
      authorize @admin_confirmed_bookings_files
    end

    def download
      @admin_confirmed_bookings_file = Admin::ConfirmedBookingsFile.find(params[:id])
      authorize @admin_confirmed_bookings_file
      send_data render_to_string(layout: false, file: Rails.root.join('.files', @admin_confirmed_bookings_file.file)),
                filename: "confirmed_bookings_#{@admin_confirmed_bookings_file.file}"
    end
  end
end
