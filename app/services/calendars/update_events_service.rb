module Calendars
  class UpdateEventsService < Calendars::BaseEventService
    def initialize(user)
      @user = user
      setup_client
    end

    def call
      calendar = @user.calendars.find_or_initialize_by(remote_id: calendar_item.id)
      calendar.summary = calendar_item.summary
      calendar.save
      update_events(calendar)
      OpenStruct.new(success?: true, calendar: calendar)
    end

    private

    def calendar_item
      @calendar_item ||= @client.list_calendar_lists.items.find { |a| a.id == @user.email }
    end
  end
end
