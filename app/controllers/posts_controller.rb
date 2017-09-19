class PostsController < ApplicationController
     before_action :authenticate_user!, only: [:new, :create]
    #def create 
        #@post = Post.find(params[:id])
        #@post.create(post_params)
        #redirect_to root_path
    #end
    
    
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
    
    def new
        @post = Post.new
    end
    
    def index
        @posts = Post.all.order('created_at DESC')
        #Post.all will give us all of the posts in the database.
    end
    
    private
    
    def post_params
        #the purpose of post_params is to make sure bad inputs aren't saved in the database. 
        params.require(:post).permit(:user_id, :photo, :description)
    end
end
