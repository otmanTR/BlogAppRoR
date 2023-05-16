require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/id/posts/index' do
    it 'check if it brings success response' do
      get user_posts_path(:user_id)

      expect(response).to be_successful
    end

    it 'renders the index template' do
      get user_posts_path(:user_id)
      expect(response).to render_template('index')
    end

    it 'check the response body includes correct placeholder text' do
      get user_posts_path(:user_id)
      expect(response.body).to include('<h1>Here your posts list with user_id </h1>')
    end
  end

  describe 'GET users from /users/:id to show' do
    user = User.create!(name: 'Burak', photo: 'https://picsum.photos/200/300', bio: 'I am Burak', posts_counter: 4)
    post = Post.create!(author: user, title: 'title', text: ' Post text 1', comments_counter: 0, likes_counter: 0)

    it 'check if it brings success response' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to be_successful
    end

    it 'check the response body includes correct placeholder text' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('<h1>Here your post with post_id and user_id</h1>')
    end

    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template('show')
    end
  end
end
