class PostBuilderService
  def initialize(posts)
    @posts = posts
  end

  def call
    # Attempting to maintain clean the local database
    Post.where.not(reddit_id: @posts.pluck(:id)).delete_all

    @posts.each_with_index do |post, position|
      Post.find_or_create_by(reddit_id: post[:id]) do |entry|
        entry.title = post[:title]
        entry.order = position
        entry.author = post[:author]
        entry.reddit_id = post[:id]
        entry.entry_date = Time.at(post[:created_at]).utc.to_datetime
        entry.comments = post[:comments]
      end
    end

    OpenStruct.new({ success?: true })
  rescue StandardError => e
    OpenStruct.new({ success?: true, error: e })
  end
end
