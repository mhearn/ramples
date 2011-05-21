class UsersController < ApplicationController
  
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def index
    @users = User.paginate(:page => params[:page])
    @title = "ramples users"
  end
  
  def show
    @user  = User.find(params[:id])
	  @title = "#{@user.first_name} #{@user.last_name}"
  end
  
  def new
  	@user  = User.new
    @title = "Sign Up"
  end
  
  def create
	  if @user.save
	    redirect_to @user, :flash => { :success => "Welcome to ramples.com!" }
	    sign_in @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit User"
  end
  
  def update
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => { :success => "Profile udpated." }
    else
      @title = "Edit User"
      render 'edit'
    end
  end
  
  def destroy
    user = User.find(params[:id]).destroy
    redirect_to users_path, :flash => { :success => "User #{user.first_name} #{user.last_name} was deleted." }
  end

  private
  
  def authenticate 
    deny_access unless signed_in?
  end
  
  def correct_user
    @user = User.find_by_id(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    user = User.find(params[:id])
    redirect_to(users_path, :flash => {:error =>
                           "Sorry. That action cannot be performed."}) if (!current_user.admin? || current_user?(user))
  end
end


