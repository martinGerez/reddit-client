require 'down'
class PostBuilderService
  def initialize(posts)
    @posts = posts
  end

  def call
    # Attempting to maintain clean the local database
    Post.where.not(reddit_id: @posts.pluck(:id)).delete_all
    @posts.each_with_index do |post, position|
      new_post = post_creation(post)

      if post[:thumbnail_url].present? && valid_url?(post[:thumbnail_url])
        attach_thumbnail(new_post, post[:thumbnail_url])
      end
    end

    OpenStruct.new({ success?: true })
  rescue StandardError => e
    OpenStruct.new({ success?: false, error: e })
  end

  private

  def post_creation(post)
    Post.find_or_create_by(reddit_id: post[:id]) do |entry|
      entry.title = post[:title]
      entry.order = position
      entry.author = post[:author]
      entry.reddit_id = post[:id]
      entry.entry_date = Time.at(post[:created_at]).utc.to_datetime
      entry.comments = post[:comments]
    end
  end

  def attach_thumbnail(new_post, url)
    thumbnail = Down.download(url)

    new_post.thumbnail.attach(io: thumbnail,
                              filename: thumbnail.original_filename,
                              content_type: thumbnail.content_type,
                              identify: false)
  end

  def valid_url?(string)
    uri = URI.parse(string)
    %w(http https).include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end
end
