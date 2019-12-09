class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :store_location, :login_user!, except: [:oktaoauth]

  # Okta
  def login_user!
    if !session[:netid]
      redirect_to user_oktaoauth_omniauth_authorize_path
    end
  end


  private

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if session["#{resource_or_scope}_return_to"]
      session["#{resource_or_scope}_return_to"]
    else
      session[:previous_url] || root_path
    end
  end
end
