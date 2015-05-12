# Routes Wisper events as notifications into the notification queue.
module Notifications
  class Manager
    def user_status_changed(user)
      notify('global', UserStatusNotificationSerializer.new(user).to_json)
    end

    def user_peer_id_changed(user)
      notify('global', UserPeerIdNotificationSerializer.new(user).to_json)
    end

  private

    def notify(channel, payload)
      Notifications::Queue.notify(channel, payload)
    end
  end
end
