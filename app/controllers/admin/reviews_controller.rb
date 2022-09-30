class Admin::ReviewsController < ApplicationController
  before_action :set_admin_review, only: %i[ show update destroy ]

  # GET /admin/reviews
  def index
    @admin_reviews = Admin::Review.all.where(published: :false).order(created_at: :desc)
  end

  # GET /admin/reviews/1
  def show
  end

  # PATCH/PUT /admin/reviews/1
  def update
    if @admin_review.update(published: :true)
      flash[:success] = "Review was successfully updated."
      redirect_to admin_reviews_path
    else
      flash[:alert] = "Can't update now"
      redirect_to admin_reviews_path
    end
  end

  # DELETE /admin/reviews/1
  def destroy
    @admin_review.destroy

    flash[:success] = "Review was successfully destroyed."
    redirect_to admin_reviews_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_review
      @admin_review = Admin::Review.find(params[:id])
    end
end
