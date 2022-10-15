# frozen_string_literal: true

module Admin
  class ReviewsController < ApplicationController
    before_action :set_admin_review, only: %i[show update destroy]

    # GET /admin/reviews
    def index
      @admin_reviews = Admin::Review.all.where(published: false).order(created_at: :desc)
      authorize @admin_reviews
    end

    # GET /admin/reviews/1
    def show; end

    # PATCH/PUT /admin/reviews/1
    def update
      if @admin_review.update(published: true)
        flash[:success] = t('.success')
        PublishReviewJob.perform_later(@admin_review.email)
      else
        flash[:danger] = t('.danger')
      end
      redirect_to admin_reviews_path
    end

    # DELETE /admin/reviews/1
    def destroy
      @admin_review.destroy

      NotPublishReviewJob.perform_later(@admin_review.email)
      flash[:success] = t('.success')
      redirect_to admin_reviews_url
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_review
      @admin_review = Admin::Review.find(params[:id])
      authorize @admin_review
    end
  end
end
