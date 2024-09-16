require 'google/apis/calendar_v3'

module Calendars
  class WatchService < ApplicationService
    def initialize(user, calendar)
      @user = user
      @calendar = calendar
      @service = Google::Apis::CalendarV3::CalendarService.new
    end

    def call
      @service.authorization = @user.google_access_token
      response = @service.watch_event(@calendar.remote_id, channel)
      webhook = Webhook.find_or_initialize_by(resource_id: response.resource_id)
      webhook.assign_attributes(
        user_id: @user.id,
        expiration_date: Time.at(response.expiration / 1000),
        channel_id: channel.id
      )
      webhook.save
      OpenStruct.new(success?: true, webhook: webhook)
    end

    private

    def channel
      @channel ||= Google::Apis::CalendarV3::Channel.new(
        id: SecureRandom.uuid,
        type: 'web_hook',
        address: "#{ENV['CALENDAR_WEBHOOK_URL']}/#{@calendar.id}"
      )
    end
  end
end
