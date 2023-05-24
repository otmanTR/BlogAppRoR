class Comment < ApplicationRecord
  belongs_to :author, class_name: :User
  belongs_to :post

  after_create :update_comment_counter
  after_destroy :decrement_comments_counter

  def decrement_comments_counter
    post.decrement!(:comments_counter)
  end

  def update_comment_counter
    post.increment!(:comments_counter)
  end
end
