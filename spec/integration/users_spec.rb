require 'rails_helper'

RSpec.describe 'users/index', type: :feature do
  before(:each) do
    @user = [
      User.create(
        name: 'Mustafa',
        photo: 'https://pic.com',
        bio: 'Software Engineer Turkey',
        posts_counter: 2
      ),
      User.create(
        name: 'Mert',
        photo: 'https://pic.com',
        bio: 'Software Engineer from Turkey',
        posts_counter: 3
      ),
      User.create(
        name: 'Caney',
        photo: 'https://pic.com',
        bio: 'Software Engineer from England',
        posts_counter: 3
      )
    ]
    visit users_path
  end

  it 'shows the author image' do
    expect(page).to have_css('img')
  end

  it 'shows the username of all users' do
    @user.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'shows the number of posts by each author' do
    @user.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end

  it 'redirects to users show page when clicked' do
    @user.each do |user|
      click_link user.name
      expect(page).to have_current_path(user_path(user))
      visit users_path
    end
  end
  describe 'users/show', type: :feature do
    before(:each) do
      @user = [
        User.create(name: 'Mustafa', photo: 'https://pic.com', bio: 'Software Engineer Turkey',
                    posts_counter: 2),
        User.create(name: 'Mert', photo: 'https://pic.com', bio: 'Software Engineer from England',
                    posts_counter: 3)
      ]

      @first_user = User.first
      @first_post = Post.create(author: @first_user, title: 'Hello', text: 'This is my first post from Mert',
                                comments_counter: 1, likes_counter: 1)
      @second_post = Post.create(author: @first_user, title: 'How are you?', text: 'This is my second post from Mert',
                                 comments_counter: 0, likes_counter: 1)
      @third_post = Post.create(author: @first_user, title: 'How are you?', text: 'This is my third post from Mert',
                                comments_counter: 0, likes_counter: 1)
      visit user_path(@first_user)
    end

    it 'shows the author name' do
      expect(page).to have_content(@first_user.name)
    end

    it 'shows the author image' do
      expect(page).to have_css('img')
    end

    it 'shows the user bio' do
      expect(page).to have_content(@first_user.bio)
    end

    it 'shows number of posts by the author' do
      expect(page).to have_content(@first_user.posts_counter)
    end

    it 'shows the users first three posts' do
      expect(page).to have_content(@first_post.text)
      expect(page).to have_content(@second_post.text)
      expect(page).to have_content(@third_post.text)
    end

    it 'shows button to view all posts' do
      expect(page).to have_link('See all posts')
    end

    it 'redirects to posts show page when users post clicked' do
      visit user_posts_path(@first_user)
      click_link @first_post.title
      expect(current_path).to match(user_posts_path(@first_user.id))
    end

    it 'it redirects me to the users posts index page when i clicked see all posts' do
      click_link 'See all posts'
      expect(current_path).to match(user_posts_path(@first_user))
    end
  end
end
