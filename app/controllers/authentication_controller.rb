class AuthenticationController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(@user = User.new(params.require(:user).permit(:email, :name, :password, :password_confirmation)))
    @user = User.find(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @sign_in_error = "Username / password combination is invalid"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end