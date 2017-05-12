class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find_by id: params[:user_id]
    if @user
      @title = t params[:link]
      @users = @user.send(params[:link]).paginate page: params[:page]
      render "users/show_follow"
    else
      flash[:danger] = t "signup.notfound"
      redirect_to root_url
    end
  end

  def create
    @user = User.find_by id: params[:followed_id]
    if @user
      current_user.follow @user
      @unfollow = current_user.get_unfollow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "signup.notfound"
      redirect_to root_url
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    if @user
      current_user.unfollow @user
      @follow = current_user.new_follow
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "signup.notfound"
      redirect_to root_url
    end
  end
end
