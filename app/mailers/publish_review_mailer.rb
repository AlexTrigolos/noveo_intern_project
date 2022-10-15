# frozen_string_literal: true

class PublishReviewMailer < ApplicationMailer
  default from: ENV.fetch('MAILER_USER', nil)

  def notice_publish
    mail to: params[:email], subject: t('.publish_review')
  end

  def notice_not_publish
    mail to: params[:email], subject: t('.not_publish_review')
  end
end
