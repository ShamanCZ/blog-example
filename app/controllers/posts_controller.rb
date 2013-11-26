class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  # instance variables (prefixed with @) will be passed
  # into the view automatically
  def show
    @post = Post.find(params[:id])
  end

  def create
    # params[:post] contains the attributes i'm interested in. But this line is not gonna work
    # @post = Post.new(params[:post])
    #
    # because of security reasons i need to specify exactly 
    # which parametres we want to accpt in our controllers
    @post = Post.new(params.require(:post).permit(:title, :text))
    # save it to the database
    # eturns boolean if it was saved or not
    # and i'm using that to the validations
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
 
    if @post.update(params[:post].permit(:title, :text))
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end
end
