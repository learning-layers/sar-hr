module Notifications
  class UserPeerIdNotificationSerializer < NotificationSerializer
    attributes :user

    def code
      :user_peer_id
    end

    def user
      {
        :id => object.id,
        :peer_id => object.peer_id
      }
    end
  end
end
