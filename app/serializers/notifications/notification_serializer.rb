module Notifications
  class NotificationSerializer < ActiveModel::Serializer
    attributes :code

    def code
      raise "You should define a notification code via #{self.class}#code."
    end

    def root_name
      :notification
    end
  end
end
