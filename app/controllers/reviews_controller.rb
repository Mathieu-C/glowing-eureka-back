class ReviewsController < ApplicationController
  include ActionController::Live

  def index
    reviews = Review.all
    render json: { status: 'SUCCESS', data: reviews }, status: :ok
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      render json: { status: 'SUCCESS', data: @review }, status: :ok
    else
      render json: { status: 'ERROR', errors: @review.errors.messages.values.flatten }, status: :unprocessable_entity
    end
  end

  def live
    response.headers['Content-Type'] = 'text/event-stream'

    sse = SSE.new(response.stream)
    begin
      Review.on_change do |data|
        sse.write(data, event: 'created')
      end
    rescue IOError
      # Client Disconnected
    ensure
      sse.close
    end
    render nothing: true
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
