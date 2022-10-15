# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'bookings/show', type: :view do
  let(:room) do
    Room.create!(room_name: 'room name', short_description: 'short', long_description: 'long description', price: 9.99)
  end

  before do
    assign(:booking, Booking.create!(email: 'alex@mail.ru', confirmed: false,
                                     booking_token: 'MyStringsfghjkjhgfdsdfghj', number_people: 1, room_id: room.id,
                                     check_in_date: '2023-01-01', check_out_date: '2023-02-02'))
  end

  it 'email renders attribute in <p>' do
    render
    expect(rendered).to match(/alex@mail.ru/)
  end

  it 'confirmed renders attribute in <p>' do
    render
    expect(rendered).to match(/false/)
  end

  it 'check_in_date renders attribute in <p>' do
    render
    expect(rendered).to match(/2023-01-01/)
  end

  it 'check_out_date renders attribute in <p>' do
    render
    expect(rendered).to match(/2023-02-02/)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/MyStringsfghjkjhgfdsdfghj/)
  end

  it 'number_people renders attribute in <p>' do
    render
    expect(rendered).to match(/2/)
  end
end
