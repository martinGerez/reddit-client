class Post < ApplicationRecord

  def self.dissmiss_all
    update_all(dissmissed: true)
  end

  def self.not_dissmissed
    where(dissmissed: false)
  end
end
