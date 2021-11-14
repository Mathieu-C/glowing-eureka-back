class ReviewsController < ApplicationController
  def index
    reviews = Review.all
    render json: { status: 'SUCCESS', data: reviews }, status: :ok
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      render json: { status: 'SUCCESS', data: @review }, status: :ok
    else
      render json: { status: 'ERROR', errors: @review.errors }, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
