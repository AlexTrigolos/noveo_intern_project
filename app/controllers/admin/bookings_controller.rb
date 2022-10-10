class Admin::BookingsController < ApplicationController
  before_action :set_admin_booking, only: %i[ show update destroy ]

  # GET /admin/bookings
  def index
    @admin_bookings = Admin::Booking.all.where(confirmed: :false).order(created_at: :desc)
    authorize @admin_bookings
  end

  # GET /admin/bookings/1
  def show
  end

  # PATCH/PUT /admin/bookings/1
  def update
    if @admin_booking.update(confirmed: :true)
      flash[:success] = "Booking was successfully updated."
      redirect_to admin_bookings_path
    else
      flash[:danger] = "Can't update now"
      redirect_to admin_bookings_path
    end
  end

  # DELETE /admin/bookings/1
  def destroy
    @admin_booking.destroy

    flash[:success] = "Booking was successfully destroyed."
    redirect_to admin_bookings_url
  end

  def confirmed_bookings
    @admin_bookings = Admin::Booking.all.where(confirmed: :true).order(created_at: :desc)
    authorize @admin_bookings
    respond_to do |format|
      format.html
      format.zip do
        ExportBookingsZipJob.perform_later current_user
        flash[:success] = "Start zip bookings"
        redirect_to confirmed_bookings_admin_bookings_path
      end
      format.csv do
        file_name = "#{Time.now.strftime("%Y-%m-%d_%H-%M-%S")}.csv"
        ExportBookingsCsvJob.perform_later(file_name)

        flash[:success] = "Start csv all bookings with name \"confirmed_bookings#{file_name}\""
        redirect_to admin_confirmed_bookings_files_path
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_booking
    @admin_booking = Admin::Booking.find(params[:id])
    authorize @admin_booking
  end
end
