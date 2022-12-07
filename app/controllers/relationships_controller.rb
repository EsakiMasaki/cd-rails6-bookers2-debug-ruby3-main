class RelationshipsController < ApplicationController
  def create
    relationship = current_user.relationships.new(followed_id: params[:user_id])
    relationship.save
    redirect_to request.referer
  end

  def destroy
    relationship = current_user.relationships.find_by(followed_id: params[:user_id])
    relationship.destroy
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
