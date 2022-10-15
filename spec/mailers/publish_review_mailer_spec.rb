# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublishReviewMailer, type: :mailer do
  describe 'instructions' do
    let(:email) { ENV.fetch('MAILER_USER', nil) }
    let(:publish_mail) { described_class.with(email: email).notice_publish }
    let(:not_publish_mail) { described_class.with(email: email).notice_not_publish }

    it 'publish renders the subject' do
      expect(publish_mail.subject).to eql('Your review has been published.')
    end

    it 'publish renders the receiver email' do
      expect(publish_mail.to).to eql([email])
    end

    it 'publish renders the sender email' do
      expect(publish_mail.from).to eql([ENV.fetch('MAILER_USER', nil)])
    end

    it 'not publish renders the subject' do
      expect(not_publish_mail.subject).to eql('Your review has not been published.')
    end

    it 'not publish renders the receiver email' do
      expect(not_publish_mail.to).to eql([email])
    end

    it 'not publish renders the sender email' do
      expect(not_publish_mail.from).to eql([ENV.fetch('MAILER_USER', nil)])
    end
  end
end
