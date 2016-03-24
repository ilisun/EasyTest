class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :post

  validates :body, presence: true

  def ensure_can_change?
    return self.created_at  >= (Time.now - 15.minutes)
  end
end
