class Admin::BookingsController < ApplicationController
  before_action :set_admin_booking, only: %i[ show update destroy ]

  # GET /admin/bookings
  def index
    @admin_bookings = Admin::Booking.all.where(confirmed: :false).order(created_at: :desc)
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_booking
    @admin_booking = Admin::Booking.find(params[:id])
  end
end
