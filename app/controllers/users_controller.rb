class UsersController < ApplicationController
  
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
  def index
    @users = User.all
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
    @user = User.new(params[:user])
	  if @user.save
	    redirect_to @user, :flash => { :success => "Welcome to ramples.com!" }
	    sign_in @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end
  
  def edit
    @user  = User.find(params[:id])
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

  def authenticate 
    deny_access unless signed_in?
  end
  
  def correct_user
    @user = User.find_by_id(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end


