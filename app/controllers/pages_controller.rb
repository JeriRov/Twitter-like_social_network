class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :data_index
  def index
    unless  session[:user_id]
      redirect_to new_user_session_path
    end
  end

  def data_index
    @users = User.all_except(current_user)
    @posts = Post.all.order(created_at: :desc)
    @friends = current_user.friends
    @suggestions = []
    @users.each do |user|
      check = false
      @friends.each do |friend|
        check = true if user.id == friend[:friend]
      end
      @suggestions << user unless check
    end
    @friend_posts = []
    @posts.each do |post|
      unless @suggestions.include?(post.user)
        @friend_posts << post
      end
    end
  end

end
