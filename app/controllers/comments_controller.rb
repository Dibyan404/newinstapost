class CommentsController < ApplicationController
    before_action :authenticate_user!, only: :create
   
    def create
        @post = Post.find(params[:id])
        @comment = @post.comments.create(comment_params.merge(user_id:current_user.id))
        #since the comment belongs to a Post and a User as well, we can't chain the method like this: current_user.@post.comments.create.
        #we can use this merge method to merge in the user_id and set it to current_user.id. That's what .merge(user_id: current_user.id) is doing right here.
        if @comment.valid?
            redirect_to root_path
        else
            flash[:alert] = "Invalid atttributes"
            redirect_to root_path
        end
    end
    
    private
    
    def comment_params
        params.require(:comment).permit(:text, :post_id)
    end
    
end
