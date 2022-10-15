# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/reviews', type: :request do
  let(:valid_attributes) { { name: 'alex', email: 'alex@mail.ru', review: 'qwertyuio' } }

  let(:invalid_attributes) do
    { name: '', email: '', review: '' }
  end

  describe 'not authorized' do
    describe 'GET /index' do
      it 'redirect to root' do
        Admin::Review.create! valid_attributes
        get admin_reviews_url
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET /show' do
      it 'redirect to root' do
        review = Admin::Review.create! valid_attributes
        get admin_review_url(review)
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) { {} }

        it 'redirect to root' do
          review = Admin::Review.create! valid_attributes
          patch admin_review_url(review), params: { admin_review: new_attributes }
          review.reload
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid parameters' do
        it 'redirect to root' do
          review = Admin::Review.create! valid_attributes
          patch admin_review_url(review), params: { admin_review: invalid_attributes }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'redirect to root' do
        review = Admin::Review.create! valid_attributes
        delete admin_review_url(review)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
