# This controller is for events delivered by server-sent events.
#
# ActionController::Live has a number of drawbacks, the greatest of which is
# the need to keep a database connection around for each request.
#
# Rails 5 and ActionCable should provide a more integrated way of handling
# notifications via websockets in the future. Until then, this is okay.
class NotificationsController < ApplicationController
  include ActionController::Live

  before_action :set_content_type

  def show
    channel = Channel.new(params[:channel])

    # Checks whether the user is allowed to access the channel.
    authorize(channel)

    # ActionController::Live provides support for server-sent events
    responder = SSE.new(response.stream)

    # Write notifications until the client disconnects
    Notifications::Queue.subscribe(channel) do |payload|
      begin
        responder.write(payload) unless payload.nil?
      rescue ClientDisconnected, IOError
        true
      end
    end
  ensure
    responder.close unless responder.nil?
  end

protected

  # Sets the content type header for an event stream.
  def set_content_type
    response.headers['Content-Type'] = 'text/event-stream'
  end
end
