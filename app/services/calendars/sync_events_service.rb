module Calendars
  class SyncEventsService < Calendars::BaseEventService
    def initialize(calendar)
      @calendar = calendar
      @user = calendar.user
      setup_client
    end

    def call
      update_events(@calendar)
      OpenStruct.new(success?: true, calendar: @calendar)
    end
  end
end
