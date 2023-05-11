require 'rails_helper'

RSpec.describe Comment, type: :model do
    user1 = User.new(name: 'Burak', photo: 'https://picsum.photos/200/300', bio: 'I am Burak', posts_counter: 4)
    post1 = Post.new(author: user1, title: 'PostTitle1', text: ' Post text 1', comments_counter: 6, likes_counter: 5)    
    
like1 = Like.new(author: user1, post: post1)

it 'check like1s user name is Burak' do
    expect(like1.author.name).to eq('Burak')
end

it 'check like1s posts title is PostTitle1' do
    expect(like1.post.title).to eq('PostTitle1')
end

it ' check likes_counter increment' do
    post1.likes_counter = 0
    post1.save

    like1 = Like.new(author: user1, post: post1)
    like1.update_like_counter

    expect(post1.likes_counter).to eq(1)
end

  end