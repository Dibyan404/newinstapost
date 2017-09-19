class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id
      #We need post_id because each comment will belong to a single photo.
      t.integer :user_id
      #We also need user_id because each comment belongs to one single user.
      t.text :text
      #We need text because we need to store the contents of the comment.
      t.timestamps null: false
    end
    add_index :comments, [:user_id, :post_id]
      #Let's look at the first line. What we're doing here is making an index of a Comment with a pair of user_id and post_id. For example, one comment might have a user_id of 12 and a post_id of 322. In this case, by making an index of a pair of post_id and user_id, if we do a query like this:
      #current_user.comments.where(post_id: 332)
      #the lookup will be faster. This is because in this case, we are querying the database for Comments with the user_id of the current_user, where the post_id is 322. In other words, we are looking Comments with a particular set of user_id and post_id, so creating an index of :comments, [:user_id, :post_id] makes the lookup super fast.
    add_index :comments, :post_id
      #Unfortunately, add_index :comments, [:user_id, :post_id] will work for looking up a pair of user_id and post_id, but it can't lookup just the post_id alone without the user_id. That's why we need to add in add_index :comments, :post_id as well.
  end
end
