require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users/index' do
    it 'check if it brings success response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template('index')
    end

    it 'check the response body includes correct placeholder text' do
      get users_path
      expect(response.body).to include('Here your users list')
    end
  end

  describe 'GET users from /users/:id to show' do
    user = User.create!(name: 'Burak', photo: 'https://picsum.photos/200/300', bio: 'I am Burak', posts_counter: 4)

    it 'check if it brings success response' do
      get "/users/#{user.id}"
      expect(response).to be_successful
    end

    it 'check the response body includes correct placeholder text' do
      get "/users/#{user.id}"
      expect(response.body).to include('<h1>Here your user with id</h1>')
    end

    it 'renders the show template' do
      get "/users/#{user.id}"
      expect(response).to render_template('show')
    end
  end
end
