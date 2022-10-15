# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rooms/show', type: :view do
  before do
    assign(:room, Room.create!(room_name: 'Room Name', short_description: 'MyText',
                               long_description: 'MyTextLong', price: '9.99'))
  end

  it 'room_name renders attribute in <p>' do
    render
    expect(rendered).to match(/Room Name/)
  end

  it 'short_description renders attribute in <p>' do
    render
    expect(rendered).to match(/MyText/)
  end

  it 'price renders attribute in <p>' do
    render
    expect(rendered).to match(/9.99/)
  end
end
