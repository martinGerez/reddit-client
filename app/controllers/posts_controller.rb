class PostsController < ApplicationController
  before_action :set_post, only: %i(dissmiss)

  def new_posts
    result = RedditServices::TopPostsService.new.call

    if result && result.success?
    end
  end


  def index


    if result && result.success?
      @posts = Post.not_dissmissed
    else
      @posts = []
    end
  end

  def dissmiss
    @post.update(dissmissed: true)
  end

  def dissmiss_all
    Post.dissmiss_all
  end

  def show; end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
