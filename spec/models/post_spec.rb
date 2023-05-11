require 'rails_helper'

RSpec.describe Post, type: :model do
  user1 = User.new(name: 'Burak', photo: 'https://picsum.photos/200/300', bio: 'I am Burak', posts_counter: 4)
  post1 = Post.new(author: user1, title: 'PostTitle1', text: ' Post text 1', comments_counter: 6, likes_counter: 5)

  it 'check post1 title presence validation' do
    post1.title = ''
    expect(post1).to_not be_valid
  end

  it 'check post1s title length higher than 250 validation' do
    post1.title = 'qwe' * 100
    expect(post1).to_not be_valid
  end

  it 'check post1s comments_counter only_integer validation' do
    post1.comments_counter = 'qwe'
    expect(post1).to_not be_valid
  end

  it 'check post1s comments_counter greater_than_or_equal_to: 0 validation' do
    post1.comments_counter = -2
    expect(post1).to_not be_valid
  end

  it 'check post1s likes_counter only_integer validation' do
    post1.likes_counter = 'qwe'
    expect(post1).to_not be_valid
  end

  it 'check post1s likes_counter greater_than_or_equal_to: 0 validation' do
    post1.likes_counter = -2
    expect(post1).to_not be_valid
  end

  it 'check post1s update_post_counter incrementation' do
    user1.posts_counter = 0
    user1.save

    post = Post.create!(author: user1, title: 'title', text: ' Post text 1', comments_counter: 0, likes_counter: 0)

    post.update_post_counter
    post.update_post_counter

    expect(user1.posts_counter).to eq(3)
  end

  it 'check bring recent_five_comments' do
    user1 = User.new(name: 'Burak', photo: 'https://picsum.photos/200/300', bio: 'I am Burak', posts_counter: 4)

    post1 = Post.new(author: user1, title: 'PostTitle1', text: ' Post text 1', comments_counter: 6,
                     likes_counter: 5)
    @comment1 = Comment.create!(author: user1, post: post1, text: 'burakk')
    @comment2 = Comment.create!(author: user1, post: post1, text: 'burakk')
    @comment3 = Comment.create!(author: user1, post: post1, text: 'burakk')
    @comment4 = Comment.create!(author: user1, post: post1, text: 'burakk')
    @comment5 = Comment.create!(author: user1, post: post1, text: 'burakk')
    @comment6 = Comment.create!(author: user1, post: post1, text: 'burakk')

    expect(post1.recent_five_comments).to eq([@comment6, @comment5, @comment4, @comment3, @comment2])
  end
end
