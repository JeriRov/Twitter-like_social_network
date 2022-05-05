class FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friend, only: %i[ show edit update destroy ]
  before_action :correct_user, only: %i[edit update destroy]
  # GET /friends or /friends.json
  def index
    @friends = current_user.friends
    @user = User.all
  end

  # GET /friends/1 or /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    #@friend = Friend.new
    @friend = current_user.friends.build
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends or /friends.json
  def create
    if params[:friend]["friend"] != ""
      unless current_user.friends.find_by(friend: params[:friend]["friend"])
        # @friend = Friend.new(friend_params)
        @friend = current_user.friends.build(friend_params)
        @friend.user_id = current_user.id
        redirect_back(fallback_location: :home_path)
        respond_to do |format|
          if @friend.save
            format.html
            format.json
          end
        end
      end
      end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy
    redirect_back(fallback_location: :home_path)
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end

  def correct_user
    @friend = current_user.friends.find_by(id: params[:id])
    redirect_to friends_path, notice: "Not Authorized To Edit This Friend" if @friend.nil?
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_friend
    @user = User.all
    @friend = Friend.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def friend_params
    params.require(:friend).permit(:friend)
  end
end
