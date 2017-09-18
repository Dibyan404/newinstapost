class PostsController < ApplicationController
    #def create 
        #@post = Post.find(params[:id])
        #@post.create(post_params)
        #redirect_to root_path
    #end
    def new
        @post = Post.new
    end
end
