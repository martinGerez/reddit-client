class Post < ApplicationRecord
  validates :title, :author, :entry_date, :comments, :reddit_id, presence: true

  has_one_attached :thumbnail

  # I have uniqueness constraint at DB level, is a good practice have this validation at
  # app level in order to handle better the errors
  validates :reddit_id, uniqueness: true

  def self.dissmiss_all
    update_all(dissmissed: true)
  end

  def self.not_dissmissed
    where(dissmissed: false)
  end
end
