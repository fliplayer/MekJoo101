class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		if params[:query].present?
			@posts = Post.search(params[:query], operator: "or", page: params[:page], :per_page => 5)
		else
			@posts = Post.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
		end
	end

	def new
		@post = Post.new
	end

	def show
		@post = Post.find(params[:id])
	end

	def create
		@post = Post.new(post_params)
		@post.skip_validation = true

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
		@post.skip_validation = true

		if @post.update(params[:post].permit(:title, :subtitle, :body))
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

	private

	def post_params
		params.require(:post).permit(:title, :subtitle, :body)
	end
end
