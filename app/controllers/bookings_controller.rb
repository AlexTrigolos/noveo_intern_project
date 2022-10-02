class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]

  # GET /bookings
  def index
    @bookings = Booking.where(booking_token: params[:query]) || []
    index = 1
    unless cookies["best-hotel_#{index}"].nil?
      @bookings = Booking.where(booking_token: cookies["best-hotel_#{index}"]).or(Booking.where(booking_token: params[:query]))
    end
    index = 2
    until cookies["best-hotel_#{index}"].nil?
      @bookings = @bookings.or(Booking.where(booking_token: cookies["best-hotel_#{index}"]))
      index += 1
    end
  end

  # GET /bookings/1
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  def create
    @booking = Booking.new(booking_params)
    booking_token = SecureRandom.base58(24 + rand(17))
    until Booking.find_by(booking_token: booking_token).nil?
      booking_token = SecureRandom.base58(24 + rand(17))
    end
    @booking.booking_token = booking_token
    @booking.room_id = params[:room]
    if @booking.check_in_date.nil? || @booking.check_out_date.nil? ||
      @booking.check_in_date < Time.now || @booking.check_in_date >= @booking.check_out_date
      flash.now[:danger] =
        "Check your date. Check-out date must be greater than check-in date and check-in can't be less than today"
      return render :new, status: :unprocessable_entity
    end
    if @booking.save
      RoomsBooking.create!(room_id: params[:room], booking_id: @booking.id)
      add_cookie(booking_token)
      flash[:success] =
        "Booking was successfully created. Admin will check it. YOUR BOOKING IS \"#{booking_token}\" SAVE IT"
      redirect_to booking_url(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookings/1
  def update
    if params[:booking][:check_in_date].nil? || params[:booking][:check_out_date].nil? ||
      params[:booking][:check_in_date] < Time.now || params[:booking][:check_in_date] >= params[:booking][:check_out_date]
      flash.now[:danger] =
        "Check your date. Check-out date must be greater than check-in date and check-in can't be less than today"
      render :edit, status: :unprocessable_entity
    elsif @booking.update(booking_params) && @booking.update(confirmed: :false)
      add_cookie(@booking.booking_token)
      flash[:success] = "Booking was successfully updated."
      redirect_to booking_url(@booking)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /bookings/1
  def destroy
    index = 1
    until cookies["best-hotel_#{index}"].nil?
      if cookies["best-hotel_#{index}"] == @booking.booking_token
        cookies.delete "best-hotel_#{index}"
      end
      index += 1
    end
    @booking.destroy

    flash[:success] = "Booking was successfully destroyed."
    redirect_to bookings_url
  end

  private

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
    @booking = Booking.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def booking_params
    params.require(:booking).permit(:email, :check_in_date, :check_out_date, :number_people)
  end
end
