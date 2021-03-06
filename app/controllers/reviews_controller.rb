class ReviewsController < ApplicationController
  # skip_before_action :authenticate_user!
  before_action :find_artist, only: [ :new, :create ]

  def new
    @review = Review.new
  end

  def create
    @review = @artist.reviews.build(review_params)
    if @review.save
      redirect_to artist_path(@artist)
    else
      render "artists/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :stars)
  end
  def find_artist
    @artist = Artist.find(params[:artist_id])
  end
end
