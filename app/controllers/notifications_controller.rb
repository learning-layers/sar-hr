# This controller is for events delivered by server-sent events.
#
# ActionController::Live has a number of drawbacks, the greatest of which is
# the need to keep a database connection around for each request.
#
# Another interesting point is that Warden's catch(:warden) block doesn't work
# when we're running on a different thread. We need to catch it ourselves to
# prevent an error and then check if the user is logged in.
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

  # We're running on a separate thread, so Warden can't catch the symbol when
  # authentication fails. We need to do that manually and fail.
  def authenticate_user!
    catch(:warden) do
      super
    end

    render_unauthorized unless user_signed_in?
  end

  # Sets the content type header for an event stream.
  def set_content_type
    response.headers['Content-Type'] = 'text/event-stream'
  end
end
