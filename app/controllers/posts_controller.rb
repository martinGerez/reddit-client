class PostsController < ApplicationController
  before_action :set_post, only: %i(dissmiss show)

  def new_posts
    result = RedditServices::TopPostsService.new.call

    if result && result.success?
      @posts = Post.not_dissmissed.order(order: :asc).page(params[:page])

      render json: { html: render_to_string(partial: 'posts/list', locals: { posts: @posts }) }
    end
  end


  def index
    @posts = Post.not_dissmissed.order(order: :asc).page(params[:page])

    respond_to do |format|
      format.html
      format.js {}
    end
  end

  def dissmiss
    @post.update(dissmissed: true)
  end

  def dissmiss_all
    Post.dissmiss_all
  end

  def show
    @post.update(read: true) unless @post.read?
    render json: { html: render_to_string(partial: 'posts/detail', locals: { post: @post }) }
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
