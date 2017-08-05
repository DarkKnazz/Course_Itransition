class WelcomeController < ApplicationController
  def index
    @posts = Post.all.order("updated_at DESC").limit(15)
  end
end
