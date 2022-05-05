class RoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @room = Room.new
    @rooms = Room.public_rooms

    @users = friends_message(User.all_except(current_user))
    render 'index'
  end

  def show
    @single_room = Room.find(params[:id])
    @room = Room.new
    @rooms = Room.public_rooms
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    @users = friends_message(User.all_except(current_user))
    render 'index'
  end

  def create
    @room = Room.create(name: params["room"]["name"])
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

end
