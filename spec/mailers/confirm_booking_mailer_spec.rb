# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConfirmBookingMailer, type: :mailer do
  describe 'instructions' do
    let(:email) { ENV.fetch('MAILER_USER', nil) }
    let(:confirm_mail) { described_class.with(email: email).notice_confirm }
    let(:not_confirm_mail) { described_class.with(email: email).notice_not_confirm }

    it 'confirm renders the subject' do
      expect(confirm_mail.subject).to eql('Your booking has been confirmed.')
    end

    it 'confirm renders the receiver email' do
      expect(confirm_mail.to).to eql([email])
    end

    it 'confirm renders the sender email' do
      expect(confirm_mail.from).to eql([ENV.fetch('MAILER_USER', nil)])
    end

    it 'not confirm renders the subject' do
      expect(not_confirm_mail.subject).to eql('Your booking has been declined.')
    end

    it 'not confirm renders the receiver email' do
      expect(not_confirm_mail.to).to eql([email])
    end

    it 'not confirm renders the sender email' do
      expect(not_confirm_mail.from).to eql([ENV.fetch('MAILER_USER', nil)])
    end
  end
end
