class Like < ApplicationRecord
    belongs_to :author, class_name: :User
    belongs_to :post

    after_create :update_like_counter

private

    def update_like_counter
        post.increment!(:likes_counter)
        end
end
#third_user = User.create(name: 'Merto', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
#Post.find(1).update(text: "first try", title: "try" )
#User.find(1).update(bio: 'Web developer from Turkey')
# third_post = Post.create(author: second_user, title: 'Hello', text: 'This is my third post')
# fourth_post = Post.create(author: second_user, title: 'Hello', text: 'This is my fourth post')
# Comment.create(post: first_post, author: second_user, text: 'Hi Tom!' )
# Comment.create(post: first_post, author: first_user, text: 'Hi Tom1!' )
# Comment.create(post: second_post, author: second_user, text: 'Hi Tom!' )
# Comment.create(post: third_post, author: first_user, text: 'Hi Tomss!' )
# Comment.create(post: fourth_post, author: second_user, text: 'Hi Tomsaless!' )
# Comment.create(post: third_post, author: first_user, text: 'Hi Tom third!' )