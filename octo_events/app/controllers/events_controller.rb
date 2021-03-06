class EventsController < ApplicationController
  def create
    event_info = JSON.parse(request.body.read)

    puts event_info[:action]
    puts event_info[:issue]
  end
end
