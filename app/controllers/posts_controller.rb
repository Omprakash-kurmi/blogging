# class PostsController < ApplicationController
#   before_action :set_post, only: [:show, :edit, :update, :destroy]

#   # GET /posts
#   def index
#     @posts = Post.all
#   end

#   # GET /posts/:id
#   def show
#   end

#   # GET /posts/new
#   def new
#     @post = Post.new
#   end

#   # POST /posts
#   def create
#     @post = Post.new(post_params)

#     if @post.save
#       redirect_to @post, notice: 'Post was successfully created.'
#     else
#       render :new
#     end
#   end

#   # GET /posts/:id/edit
#   def edit
#   end

#   # PATCH/PUT /posts/:id
#   def update
#     if @post.update(post_params)
#       redirect_to @post, notice: 'Post was successfully updated.'
#     else
#       render :edit
#     end
#   end

#   # DELETE /posts/:id
#   def destroy
#     @post.destroy
#     redirect_to posts_url, notice: 'Post was successfully destroyed.'
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_post
#       @post = Post.find(params[:id])
#     end

#     # Only allow a trusted parameter "white list" through.
#     def post_params
#       params.require(:post).permit(:title, :body)
#     end
# end

# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = if params[:search]
               Post.search_full_text(params[:search]).page(params[:page]).per(5)
             else
               @q.result.page(params[:page]).per(5)
             end
  end

  def show; end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    authorize @post

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post

    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
