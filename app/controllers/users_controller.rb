class UsersController < ApplicationController 
  before_action :prevent_login_signup, only: [:signup, :login]

  def new
    @user = User.new 
  end

  def create
    @user = User.create user_params
    puts user_params
    found_user_by_username = User.where(username: params[:username]).first
    found_user_by_email = User.where(email: params[:email]).first
    if found_user_by_username or found_user_by_email
      flash[:error] = "That username or email already exists. Try something different."
      redirect_to new_user_path
    elsif @user.save
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash[:error] = "Nuh uh uh. Try again."
      render :new
    end
  end

  def edit
    
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = User.where(username: params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
          if authorized_user
            session[:user_id] = authorized_user.id
            redirect_to books_path
          else
            flash[:error] = "Your username or password is invalid"
            redirect_to root_path 
          end
      else
        flash[:error] = "Your username or password is invalid"
        redirect_to root_path
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Goodbye!"
    redirect_to root_path
  end


  private
  def user_params
    params.require(:user).permit(:id, :username, :name, :password, :email, :password_digest)
  end

  def prevent_login_signup
    if session[:user_id]
      redirect_to books_path
    end
  end
  
end
