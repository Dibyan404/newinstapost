class PostsController < ApplicationController
    #def create 
        #@post = Post.find(params[:id])
        #@post.create(post_params)
        #redirect_to root_path
    #end
    before_action :authenticate_user!, only: [:new, :create]
    
    def create
        @post = current_user.posts.create(post_params)
        # current_user.current_user is a Devise helper method that returns the User object of the current user that is logged in
        # current_user.posts.create(post_params) code. What this is saying is, create a post by current_user. This automatically hooks up and connects the current_user with the created post. In other words, the user_id of the new Post is set to the id of current_user, so that we know who posted it.
        if @post.valid?
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    private
    
    def post_params
        #the purpose of post_params is to make sure bad inputs aren't saved in the database. 
        params.require(:post).permit(:user_id, :photo, :description)
    end
    
    def new
        @post = Post.new
    end
end
