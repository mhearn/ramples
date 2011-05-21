class UsersController < ApplicationController
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
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => { :success => "Profile udpated." }
    else
      @title = "Edit User"
      render 'edit'
    end
  end
end
