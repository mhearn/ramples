class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
	@title = "#{@user.first_name} #{@user.last_name}"
  end
  
  def new
  	@user = User.new
    @title = "Sign Up"
  end
  
  def create
    @user = User.new(params[:user])
	if @user.save
	  redirect_to @user, :flash => { :success => "Welcome to eFFoveo!" }
	else
	  @title = "Sign Up"
	  render 'new'
	end
  end
end
