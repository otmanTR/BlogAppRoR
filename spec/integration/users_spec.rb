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

end
