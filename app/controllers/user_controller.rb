class UserController < ApplicationController
  include ApplicationHelper

  before_filter :protect, :only => [:index, :edit]

  def index
    @title = "Transport Management User Profile"
    @user = User.find(session[:user_id])
  end

  # Edit the user's basic info.
  def edit
    @title = "Edit Your Information"
    @user = User.find(session[:user_id])
    if param_posted?(:user)
      attribute = params[:attribute]
      case attribute
      when "email"
        try_to_update @user, attribute
      when "password"
        if @user.correct_password?(params)
          try_to_update @user, attribute
        else
          @user.password_errors(params)
        end
      end
    end
    @user.clear_password!
  end


  def register
    @title = "Register"
    if param_posted?(:user)
      @user = User.new(params[:user])
      if @user.save
        @user.login!(session)
        flash[:notice] = "User #{@user.screen_name} created!"
        redirect_to_forwarding_url
      else
        @user.clear_password!
      end
    end
  end
  
  def login
    @title = "Log in to Transport Management"
    if param_posted?(:user)
      @user = User.new(params[:user])
      user = User.find_by_screen_name_and_password(@user.screen_name,
        @user.password)
      if user
        user.login!(session)
        flash[:notice] = "User #{user.screen_name} logged in!"
        redirect_to_forwarding_url
      else        
        @user.clear_password!
        flash[:notice] = "Invalid screen name/password combination"
      end
    end
  end

  def logout
    User.logout!(session)
    flash[:notice] = "Logged out"
    redirect_to :action => "index", :controller => "site"

  end

  private
  # Protect a page from unauthorized access.
  def protect
    unless logged_in?
      session[:protected_page] = request.request_uri
      flash[:notice] = "Please log in first"
      redirect_to :action => "login"
      return false
    end
  end

  # Return true if a parameter corresponding to the given symbol was posted.
  def param_posted?(symbol)
    request.post? and params[symbol]
  end

  # Redirect to the previously requested URL (if present).
  def redirect_to_forwarding_url
    if (redirect_url = session[:protected_page])
      session[:protected_page] = nil
      redirect_to redirect_url
    else
      redirect_to :action => "index"
    end
  end

  # Try to update the user, redirecting if successful.
  def try_to_update(user, attribute)
    if user.update_attributes(params[:user])
      flash[:notice] = "User #{attribute} updated."
      redirect_to :action => "index"
    end
  end
end
