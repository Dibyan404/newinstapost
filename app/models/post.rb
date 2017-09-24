class Post < ActiveRecord::Base
    belongs_to :user
    has_many :comments, dependent: :destroy
    mount_uploader :photo, PhotoUploader
    validates :photo, :description, :user_id, presence: true
    acts_as_votable
    #to make post votable
    delegate :photo, :name, to: :user, prefix: true
    
    #The Law of Demeter: In the simplest terms, the Law of Demeter states that an object should not call methods through another object. It is also called the principle of least knowledge.
    #instead of accessing the photo of the user directly (post.user.photo), we have created a method inside of the Post class that we can use to access the same data: post.user_photo.
    #However, this can become repetitive, and fortunately Rails provides a convenient method to achieve this; the delegate method
end
