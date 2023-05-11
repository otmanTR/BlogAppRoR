require 'rails_helper'

RSpec.describe User, type: :model do
   user1 = User.new(name: 'Burak', photo: 'https://picsum.photos/200/300', bio: 'I am Burak', posts_counter: 4)
   user2 = User.new(name: 'Ahmet',photo: 'https://picsum.photos/200/300', bio: 'I am Ahmet', posts_counter: -2)
   user3 = User.new(name: '',photo: 'https://picsum.photos/200/300', bio: 'I am Ahmet', posts_counter: 3)
  
    it 'check user1s name not be blank' do
      expect(user1.name).to_not eq('')
    end

    it 'check user1s photo is a string' do
      expect(user1.photo).to eq('https://picsum.photos/200/300')
    end

    it 'check user1s bio is a string' do
      expect(user1.bio).to eq('I am Burak')
    end

    it 'check user1s name shorter than 250 characters' do
      expect(user1.name.length < 250).to eq(true)
    end

    it 'check user1s posts_counter be integer' do
      expect(user1.posts_counter >= 0).to eq(true)
    end

    it 'check user2s posts_counter lower than 0' do
      expect(user2).to_not be_valid
    end

    it 'check user3s name not be blank' do
      expect(user3).to_not be_valid
    end

    it 'need to bring users1s last three posts'do
    user1.save
  @post1 = user1.posts.create!(title: 'burak', text: 'Burak', comments_counter:2, likes_counter:2)
  @post2 = user1.posts.create!(title: 'burak1', text: 'Burak1', comments_counter:2, likes_counter:2)
  @post3 = user1.posts.create!(title: 'burak2', text: 'Burak2', comments_counter:2, likes_counter:2)
  @post4 = user1.posts.create!(title: 'burak3', text: 'Burak3', comments_counter:2, likes_counter:2)
  
  expect(user1.recent_three_posts).to eq([@post4, @post3, @post2])
  end
  
  end