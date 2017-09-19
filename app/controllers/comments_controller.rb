class CommentsController < ApplicationController
    before_action :is_owner?, only: :destroy
    before_action :authenticate_user!, only: :create
    #adding authentication to make sure that users who aren't signin aren't allowed to access the create action.
   
    def create
        @post = Post.find(params[:post_id])
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
    
    def edit
        @comment = Comment.find(params[:id])
    end
    
    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to root_path
    end

    
    
    private
    
    def comment_params
        params.require(:comment).permit(:text, :post_id)
    end
    
    def is_owner?
        @comment = Comment.find(params[:id])
        if @comment.user != current_user
            redirect_to root_path
        end
    end
    
end
