# frozen_string_literal: true

require 'rails_helper'

class RspecStream
  attr_accessor :data

  def initialize(string)
    @data = string
  end

  def read
    @data
  end
end

class RspecUser
  attr_accessor :email

  def initialize(email)
    @email = email
  end
end

RSpec.describe Admin::UserMailer, type: :mailer do
  describe 'instructions' do
    let(:user) { RspecUser.new(ENV.fetch('MAILER_USER', nil)) }
    let(:mail) { described_class.with(user: user, stream: RspecStream.new('info')).export_bookings_zip }

    it 'renders the subject' do
      expect(mail.subject).to eql('The zip file you requested with data on confirmed bookings.')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql([ENV.fetch('MAILER_USER', nil)])
    end
  end
end
