# frozen_string_literal: true

class NotPublishReviewJob < ApplicationJob
  queue_as :default

  def perform(email)
    PublishReviewMailer.with(email: email).notice_not_publish.deliver_now
  end
end
