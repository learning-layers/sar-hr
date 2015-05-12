module Notifications
  class UserStatusNotificationSerializer < NotificationSerializer
    attributes :user

    def code
      :user_status
    end

    def user
      {
        :id => object.id,
        :status => object.status
      }
    end
  end
end
