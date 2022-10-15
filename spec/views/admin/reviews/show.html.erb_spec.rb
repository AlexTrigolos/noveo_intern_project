# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin/reviews/show', type: :view do
  before do
    assign(:admin_review, Admin::Review.create!(name: 'alex', email: 'alex@mail.ru', review: 'qwertyuio'))
  end

  it 'name renders attribute in <p>' do
    render
    expect(rendered).to match(/alex/)
  end

  it 'email renders attribute in <p>' do
    render
    expect(rendered).to match(/alex@mail.ru/)
  end

  it 'review renders attribute in <p>' do
    render
    expect(rendered).to match(/qwertyuio/)
  end
end
