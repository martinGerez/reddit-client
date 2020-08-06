FactoryBot.define do
  factory :post do
    title         { 'This is my awesome post :)' }
    author        { 'Martin Gerez' }
    entry_date    { Time.now }
    comments      { rand(1..99_999) }
    reddit_id     { 10.times.map { ('a'..'z').to_a[rand(26)] }.join }
    dissmissed    { false }
  end
end
