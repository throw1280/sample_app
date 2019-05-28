class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
    :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(per_page: Settings.per_page_size,
      page: params[:page])
  end

  def show
    @user = User.find_by id: params[:id]

    if @user
      @microposts = @user.microposts.post_user.paginate(page: params[:page])
    else
      redirect_to root_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      remember @user
      flash[:success] = t "wel2"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "pup"
      redirect_to @user
    else
      render :edit
    end
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "pli"
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def destroy
    User.find_by(params[:id]).destroy
    flash[:success] = t "udel"
    redirect_to users_url
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def following
    @title = t "following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render "show_follow"
  end

  def followers
    @title = t "followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
end
