class ReviewsController < ApplicationController
  # GET /reviews
  def index
    @reviews = all_published_reviews
    @review = Review.new
  end

  # GET /reviews/1
  def show
    @review = Review.find(params[:id])
  end

  # POST /reviews
  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:success] = "Review was successfully created. Admin will check it."
      redirect_to review_path(@review)
    else
      flash.now[:danger] = "You have errors in the form."
      @reviews = all_published_reviews
      render 'reviews/index', status: :unprocessable_entity
    end
  end

  private

  def all_published_reviews
    Review.all.where(published: :true).order(created_at: :desc)
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:name, :email, :review)
  end
end
