class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def google_calendar
    @calendar = Calendar.find(params[:calendar_id])
    # TODO: MOVE TO JOB
    Calendars::SyncEventsService.call(@calendar)
    head :no_content
  end
end
