require 'google/apis/calendar_v3'

module Calendars
  class BaseEventService < ApplicationService

    protected

    def setup_client
      @client = Google::Apis::CalendarV3::CalendarService.new
      @client.client_options.application_name = ENV['GOOGLE_CLIENT_APP']
      @client.authorization = client_auth
    end

    def client_auth
      @client_auth ||= Signet::OAuth2::Client.new(
        access_token: @user.google_access_token,
        refresh_token: @user.google_refresh_token,
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        client_id: ENV['GOOGLE_CLIENT_ID'],
        client_secret: ENV['GOOGLE_CLIENT_SECRET']
      )
    end

    def update_events(calendar)
      calendar_events = @client.list_events(calendar.remote_id)
      calendar_events.items.each do |event_item|
        event = calendar.events.find_or_initialize_by(remote_id: event_item.id)
        event.assign_attributes(
          summary: event_item.summary,
          start_time: event_item.start.date_time,
          end_time: event_item.end.date_time
        )
        event.save
      end
    end
  end
end
