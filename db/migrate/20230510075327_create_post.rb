class CreatePost < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }, index: true
      t.string :title
      t.text :text
      t.integer :comments_counter
      t.integer :likes_counter

      t.timestamps
    end
  end
end
# five_post = Post.create(author: 1, title: 'Hello second', text: 'This is my second post')
# first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post', comments_counter:0, likes_counter:0)
# first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter:3)
# second_post = Post.create(author: first_user, title: 'second', text: 'This is my second post', comments_counter:0, likes_counter:0)
# third_post = Post.create(author: first_user, title: 'third', text: 'This is my third post', comments_counter:0, likes_counter:0)
# fourth_post = Post.create(author: first_user, title: 'fourth', text: 'This is my fourth post', comments_counter:0, likes_counter:0)
# fiveft_post = Post.create(author: first_user, title: 'Heveft', text: 'This is my fiveft post', comments_counter:0, likes_counter:0)
# sixth_post = Post.create(author: first_user, title: 'sixth', text: 'This is my sixth post', comments_counter:0, likes_counter:0)