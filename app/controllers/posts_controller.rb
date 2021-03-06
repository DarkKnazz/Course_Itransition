class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  autocomplete :category, :category_id

  # GET /posts
  # GET /posts.json
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).includes(:category)
    else
      if params[:val]
        @posts = Post.search(params[:val]).includes(:category)
      else
        @posts = Post.all.includes(:category)
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.includes(:tags).find(params[:id])
    @comments = @post.comments.includes(:user)
    @steps = @post.steps.paginate(:per_page => 1, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @steps }
      format.js
end
  end

  # GET /posts/new
  def new
    @post = Post.new
    @categories = Category.all
  end

  # GET /posts/1/edit
  def edit
    if @post.user_id != current_user.id && current_user.isAdmin == false
      redirect_to root_path
    end
    @step = Step.new
    @steps = @post.steps.order("position")
  end

  # POST /posts
  # POST /posts.json
  def create
    if post_params[:name].empty? || post_params[:category_id].empty?
      redirect_to new_post_path
    else
      id_Categ = Category.where(:name => post_params[:category_id])[0]
      if id_Categ == nil
        redirect_to new_post_path
      else
        @post = createConfig @post, id_Categ
        if @post.preview == ""
          @post.preview = "http://mirgif.com/KARTINKI/kosmos/kosmos-42.jpg"
          @post.save
        end
        respond_to do |format|
          format.html { redirect_to @post}
          format.json { render :show, status: :created, location: @post }
        end
    end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to edit_post_path(@post.id), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    current_user.count_Posts -= 1
    current_user.save
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @posts = Post.search(params[:val]).includes(:category)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def createConfig post, id_Categ
      post = current_user.posts.create(post_params)
      post.category_id = id_Categ.id
      post.save
      current_user.count_Posts += 1
      current_user.save
      post
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :name, :rate, :tag_list, :preview, :category_id)
    end
end
