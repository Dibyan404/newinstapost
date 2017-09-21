class UpvotesController < ApplicationController
    before_action :authenticate_user!
    
    def create
        #Instead of thinking "the user is upvoting the post",think "the user is creating an upvote"
        #By doing so, We are creating a create method so that we can keep our action to our default CRUD actions(index,show,new,edit,create,update,destroy)
        @post = Post.find(params[:post_id])
        @post.liked.by current_user
        #Since the user linking the post is current_user
        redirect_to posts_path
    end

end
