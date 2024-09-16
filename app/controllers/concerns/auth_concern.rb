module AuthConcern
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  # Find the user by the session's user ID, if it exists
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Redirect to the login page if there is no current user
  def authenticate_user!
    redirect_to root_path, notice: 'Please sign in' unless current_user
  end

  def omniauth_data
    @omniauth_data ||= request.env['omniauth.auth']
  end
end
