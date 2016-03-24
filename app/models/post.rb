class Post < ActiveRecord::Base

  scope :published, -> { where(publish: true).order(created_at: :desc) }
  scope :my, -> (user){ where(user_id: user.id).order(created_at: :desc) }

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, :body, presence: true
  validates :title, :body, length: { minimum: 10 }, allow_blank: true
  validates :title, length: { maximum: 250 }

  acts_as_taggable

end
