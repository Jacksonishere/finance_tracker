class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:user])
    friendship = current_user.friendships.build(friend_id: friend.id)
    if friendship.save
      flash[:notice] = "Following #{friend.fullname}"
    else
      flash[:notice] = "There was an error following"
    end
    redirect_to friends_path
  end

  def destroy
    if params[:id]
      friendship = Friendship.get_friendship(current_user.id, params[:id])
      friendship.destroy
      flash[:notice] = "Stopped following"
      redirect_to friends_path
    end

  end
end
