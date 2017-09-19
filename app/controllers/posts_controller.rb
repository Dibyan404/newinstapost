#1. User Opens his browser, types in a URL and presses Enter. When a user presses Enter, the browser makes a request for that URL.
#2. The request hit Rails Route{Config/routes.rb}
#3. The router maps the URL to the correct controller and action to handle the request.
#4. The controller receives the request and asks the model to fetch data from the database.
#5. The model returns a list of data to the controller action.
#6. The controller action passes the data on to the view.
#7. The view renders the page as HTML
#8. The controller sends the HTML back to the browser. The page reloads and the user sees it.

class PostsController < ApplicationController
    before_action :is_owner?, only: [:edit, :update, :destroy]
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
        #change the order of our collection of Posts by attaching the order method and giving it the parameter 'created_at DESC'. .order('created_at DESC') is saying, order it by the created_at attribute in descending order.
    end
    
    def edit
        #when the edit method in ideas_controller.rb is triggered, Rails will try to find a file called edit.html.erb inside app/views/ideas.
        @post = Post.find(params[:id])
        #What Post.find(params[:id]) is doing is, it's finding a Post with an id that matches the params[:id].
    end
    def update
        @post = Post.find(params[:id])
        @post.update(post_params)
        if @post.valid?
            redirect_to root_path
        else
            render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to root_path
    end
    
    
    private
    
    def is_owner?
        #The is_owner? method just checks if the post's user and the current_user do not match, and if so, it redirects the user to the root_path.
        reidrect_to root_path if Post.find(params[:id]).user != current_user 
    end
    
    
    
    def post_params
        #the purpose of post_params is to make sure bad inputs aren't saved in the database. 
        params.require(:post).permit(:user_id, :photo, :description)
    end
    
end
