class SessionsController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @user = User.find_or_initialize_by(email: omniauth_data.info.email)
    unless @user.update(auth_params)
      session[:user_id] = nil
      redirect_to root_path, notice: 'There was a problem logging in with Google.'
      return
    end
    session[:user_id] = @user.id
    # TODO: MOVE TO JOB
    service = Calendars::UpdateEventsService.call(@user)
    Calendars::WatchService.call(@user, service.calendar) if service.success?
    redirect_to calendars_path, notice: 'Logged in successfully with Google!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out!'
  end

  private

  def auth_params
    {
      google_access_token: omniauth_data.credentials.token,
      google_refresh_token: omniauth_data.credentials.refresh_token,
      token_expires_at: Time.now + omniauth_data.credentials.expires_at,
      name: omniauth_data.info.name,
      google_uid: omniauth_data.uid
    }
  end
end
