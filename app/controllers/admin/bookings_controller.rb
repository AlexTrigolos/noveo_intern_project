# frozen_string_literal: true

module Admin
  class BookingsController < ApplicationController
    before_action :set_admin_booking, only: %i[show update destroy]

    # GET /admin/bookings
    def index
      @admin_bookings = Admin::Booking.all.where(confirmed: false).order(created_at: :desc)
      authorize @admin_bookings
    end

    # GET /admin/bookings/1
    def show; end

    # PATCH/PUT /admin/bookings/1
    def update
      if @admin_booking.update(confirmed: true)
        flash[:success] = t('.success')
      else
        flash[:danger] = t('.danger')
      end
      redirect_to admin_bookings_path
    end

    # DELETE /admin/bookings/1
    def destroy
      @admin_booking.destroy

      flash[:success] = t('.success')
      redirect_to admin_bookings_url
    end

    def confirmed_bookings
      @admin_bookings = Admin::Booking.all.where(confirmed: true).order(created_at: :desc)
      authorize @admin_bookings
      respond_to do |format|
        format.html
        format.zip { confirmed_bookings_zip }
        format.csv { confirmed_bookings_csv }
      end
    end

    private

    def confirmed_bookings_csv
      file_name = "#{Time.now.getlocal.strftime('%Y-%m-%d_%H-%M-%S')}.csv"
      ExportBookingsCsvJob.perform_later(file_name)

      flash[:success] = "Start csv all bookings with name \"confirmed_bookings_#{file_name}\""
      redirect_to admin_confirmed_bookings_files_path
    end

    def confirmed_bookings_zip
      ExportBookingsZipJob.perform_later current_user
      flash[:success] = t('.download_zip')
      redirect_to confirmed_bookings_admin_bookings_path
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_booking
      @admin_booking = Admin::Booking.find(params[:id])
      authorize @admin_booking
    end
  end
end
