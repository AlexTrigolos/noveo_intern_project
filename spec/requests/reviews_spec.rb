# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/reviews', type: :request do
  let(:valid_attributes) { { name: 'alex', email: 'alex@mail.ru', review: 'qwertyuio' } }

  let(:invalid_attributes) { { name: '', email: '', review: '' } }

  describe 'GET /index' do
    it 'renders a successful response' do
      Review.create! valid_attributes
      get reviews_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      review = Review.create! valid_attributes
      get review_url(review)
      expect(response).to be_successful
    end
  end

  # describe 'GET /new' do
  #   it 'renders a not successful response' do
  #     expect{ get :new }.to raise_error(ActionController::RoutingError)
  #   end
  # end

  # describe 'GET /edit' do
  #   it 'renders a successful response' do
  #     review = Review.create! valid_attributes
  #     get edit_review_url(review)
  #     expect(response).to be_successful
  #   end
  # end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Review' do
        expect do
          post reviews_url, params: { review: valid_attributes }
        end.to change(Review, :count).by(1)
      end

      it 'redirects to the created review' do
        post reviews_url, params: { review: valid_attributes }
        expect(response).to redirect_to(review_url(Review.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Review' do
        expect do
          post reviews_url, params: { review: invalid_attributes }
        end.not_to change(Review, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'index' template)" do
        post reviews_url, params: { review: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # describe 'PATCH /update' do
  #   context 'with valid parameters' do
  #     let(:new_attributes) {
  #       skip('Add a hash of attributes valid for your model')
  #     }
  #
  #     it 'updates the requested review' do
  #       review = Review.create! valid_attributes
  #       patch review_url(review), params: { review: new_attributes }
  #       review.reload
  #       skip('Add assertions for updated state')
  #     end
  #
  #     it 'redirects to the review' do
  #       review = Review.create! valid_attributes
  #       patch review_url(review), params: { review: new_attributes }
  #       review.reload
  #       expect(response).to redirect_to(review_url(review))
  #     end
  #   end
  #
  #   context 'with invalid parameters' do
  #
  #     it "renders a response with 422 status (i.e. to display the 'edit' template)" do
  #       review = Review.create! valid_attributes
  #       patch review_url(review), params: { review: invalid_attributes }
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #
  #   end
  # end

  # describe 'DELETE /destroy' do
  #   it 'destroys the requested review' do
  #     review = Review.create! valid_attributes
  #     expect {
  #       delete review_url(review)
  #     }.to change(Review, :count).by(-1)
  #   end
  #
  #   it 'redirects to the reviews list' do
  #     review = Review.create! valid_attributes
  #     delete review_url(review)
  #     expect(response).to redirect_to(reviews_url)
  #   end
  # end
end
