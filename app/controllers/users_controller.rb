class UsersController < ApplicationController
  before_action :set_user
  before_action :check_friends

  def show
    @user = User.find(params[:id])
    @users = friends_message(User.all_except(current_user))
    @room = Room.new
    @rooms = Room.public_rooms
    @room_name = get_name(@user, current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    render 'rooms/index'
  end

  def profile
  end

  def friends_message(users)
    @friends = current_user.friends
    @message_friends = []
    users.each do |user|
      if current_user.friends.find_by(friend: user.id)
        @message_friends << user
      end
    end
    @message_friends
  end

  def check_friends
    @friend_checker = true
    current_user.friends.each do |friend|
      if friend[:friend] == @user.id
        @current_friend = friend
        @friend_checker = false
      end
    end
  end

  private
  def get_name(user1, user2)
    user = [user1, user2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end


  def set_user
    @user = User.find(params[:id])
  end
end
