class CalendarsController < ApplicationController
  before_action :authenticate_user!

  def index
    @calendars = current_user.calendars
  end
end
