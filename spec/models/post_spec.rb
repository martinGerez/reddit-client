require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validations spec' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:entry_date) }
    it { is_expected.to validate_presence_of(:comments) }
    it { is_expected.to validate_presence_of(:reddit_id) }
    it { is_expected.to validate_uniqueness_of(:reddit_id) }
  end

  context 'class methods spec' do
    let!(:posts) { create_list(:post, 50) }

    it 'dismiss all posts' do
      Post.dissmiss_all

      Post.all.pluck(:dissmissed).each do |dissmissed_state|
        expect(dissmissed_state).to eq(true)
      end
    end

    it 'returns all posts that are not dissmissed' do
      # I dissmiss several to test the scope
      Post.where(id: Post.first(20).pluck(:id)).update_all(dissmissed: true)

      expect(Post.not_dissmissed.count).to eq(30)
    end
  end
end
