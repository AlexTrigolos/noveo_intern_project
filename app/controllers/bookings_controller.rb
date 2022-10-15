# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]

  # GET /bookings
  def index
    @bookings = Booking.where(booking_token: params[:query]) || []
    find_by_cookies
    @bookings = @bookings.or(Booking.where(email: current_user.email)) if current_user
    @bookings = @bookings.order(check_in_date: :asc).where('check_in_date >= ?', Time.now.getlocal.to_s)
  end

  # GET /bookings/1
  def show; end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit; end

  # POST /bookings
  # rubocop:disable Metrics/MethodLength
  def create
    create_params
    if @booking.check_in_date.nil? || @booking.check_out_date.nil? ||
       @booking.check_in_date < Time.now.getlocal || @booking.check_in_date >= @booking.check_out_date
      flash.now[:danger] =
        "Check your date. Check-out date must be greater than check-in date and check-in can't be less than today"
      render :new, status: :unprocessable_entity
    elsif @booking.save
      add_cookie(@booking_token)
      flash[:success] =
        "Booking was successfully created. Admin will check it. YOUR BOOKING IS \"#{@booking_token}\" SAVE IT"
      redirect_to booking_url(@booking.booking_token)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookings/1
  def update
    if params[:booking][:check_in_date].nil? ||
       params[:booking][:check_out_date].nil? ||
       params[:booking][:check_in_date] < Time.now.getlocal ||
       params[:booking][:check_in_date] >= params[:booking][:check_out_date]
      flash.now[:danger] =
        "Check your date. Check-out date must be greater than check-in date and check-in can't be less than today"
      render :edit, status: :unprocessable_entity
    elsif @booking.update(booking_params) && @booking.update(confirmed: false)
      add_cookie(@booking.booking_token)
      flash[:success] = t('.success')
      redirect_to booking_url(@booking.booking_token)
    else
      render :edit, status: :unprocessable_entity
    end
  end
  # rubocop:enable Metrics/MethodLength

  # DELETE /bookings/1
  def destroy
    index = 1
    until cookies["best-hotel_#{index}"].nil?
      cookies.delete "best-hotel_#{index}" if cookies["best-hotel_#{index}"] == @booking.booking_token
      index += 1
    end
    @booking.destroy

    flash[:success] = t('.success')
    redirect_to bookings_url
  end

  private

  def find_by_cookies
    index = 1
    unless cookies["best-hotel_#{index}"].nil?
      @bookings =
        Booking.where(booking_token: cookies["best-hotel_#{index}"]).or(Booking.where(booking_token: params[:query]))
    end
    index = 2
    until cookies["best-hotel_#{index}"].nil?
      @bookings = @bookings.or(Booking.where(booking_token: cookies["best-hotel_#{index}"]))
      index += 1
    end
  end

  def create_params
    @booking = Booking.new(booking_params)
    @booking_token = SecureRandom.base58(rand(24..40))
    @booking_token = SecureRandom.base58(rand(24..40)) until Booking.find_by(booking_token: @booking_token).nil?
    @booking.booking_token = @booking_token
    @booking.room_id = params[:room]
  end

  def add_cookie(booking_token)
    index = 1
    until cookies["best-hotel_#{index}"].nil?
      return if cookies["best-hotel_#{index}"] == booking_token

      index += 1
    end
    cookies["best-hotel_#{index}"] = booking_token
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find_by(booking_token: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def booking_params
    params.require(:booking).permit(:email, :check_in_date, :check_out_date, :number_people)
  end
end
