class Comment < ActiveRecord::Base
    belongs_to :post
    belongs_to :user
    validates :text, :user_id, presence: true
    #Making sure that we get valid data to be saved into our database.
    #Specialically, we need to make sure that the text, post_id, and user_id is present
    delegate :name, to: :user, prefix: true
    
end
