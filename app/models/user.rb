class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable :confirmable
  devise :database_authenticatable, :registerable, :confirmable
         :recoverable, :rememberable, :validatable
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :posts, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_validation :assign_posts_counter

  def assign_posts_counter
    self.posts_counter = posts.count
  end

  def recent_three_posts
    posts.order(created_at: :desc).limit(3)
  end

  def admin?
    role == 'admin'
  end
end
