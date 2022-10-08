class Admin::UserMailer < ApplicationMailer
  def export_bookings
    @user = params[:user]
    stream = params[:stream]

    attachments['bookings.zip'] = stream.read
    mail to: @user.email, subject: "Your data"
  end
end