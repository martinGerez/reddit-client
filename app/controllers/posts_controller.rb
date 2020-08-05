class PostsController < ApplicationController
  def index
    result = RedditServices::TopPostsService.new.call

    if result && result.success?
      @posts = result.payload
    else
      @posts = []
    end
  end

  def show; end
end
