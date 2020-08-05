module RedditServices
  class TopPostsService
    include HTTParty

    def call
      response = fetch_data
      raise StandardError.new('Something went wrong with external service') unless response.msg.eql?('OK')

      entries = filter_entries(response)

      result  = build_posts(entries)
      raise StandardError.new('Something went wrong with external service') unless result.success?

      OpenStruct.new({ success?: true })
    rescue StandardError => e
      OpenStruct.new({ success?: false, error: "Something went wrong: #{e}" })
    end

    private

    def fetch_data
      HTTParty.get('https://www.reddit.com/top.json?limit=50', headers: { 'User-Agent': 'your bot 0.1' })
    end

    def filter_entries(response)
      response.dig('data', 'children').map do |entry|
        {
          id: entry.dig('data', 'id'),
          author: entry.dig('data', 'author'),
          created_at: entry.dig('data', 'created_utc'),
          title: entry.dig('data', 'title'),
          thumbnail_url: entry.dig('data', 'thumbnail'),
          comments: entry.dig('data', 'num_comments'),
          image: entry.dig('data', 'url_overridden_by_dest') # I'm not sure about this property :/
        }
      end
    end

    def build_posts(entries)
      PostBuilderService.new(entries).call
    end
  end
end
