# frozen_string_literal: true

class PublishReviewJob < ApplicationJob
  queue_as :default

  def perform(email)
    PublishReviewMailer.with(email: email).notice_publish.deliver_now
  end
end
