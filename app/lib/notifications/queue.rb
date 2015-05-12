# Uses PostgreSQL's LISTEN and NOTIFY statements to implement a simple event
# queue.
module Notifications::Queue
  extend self

  def subscribe(unescaped_channel, &block)
    ActiveRecord::Base.connection_pool.with_connection do |connection|
      channel = escape_identifier(connection, unescaped_channel)

      listen_to_channel(connection, channel, &block)
    end
  end

  def notify(unescaped_channel, unescaped_payload)
    ActiveRecord::Base.connection_pool.with_connection do |connection|
      channel = escape_identifier(connection, unescaped_channel)
      payload = escape_value(connection, unescaped_payload)

      notify_channel(connection, channel, payload)
    end
  end

private

  # Waits until a notification on the given channel is received and calls the
  # block with the payload.
  #
  # Loops until the block returns truthy.
  def listen_to_channel(connection, channel, &block)
    connection.execute("LISTEN #{channel}")

    loop do
      connection.raw_connection.wait_for_notify do |event, pid, payload|
        return if yield payload
      end
    end
  ensure
    connection.execute("UNLISTEN *")
  end

  # Notifies the given channel with the payload.
  def notify_channel(connection, channel, payload)
    connection.execute("NOTIFY #{channel}, #{payload}")
  end

  # Escapes a string for use as a Postgres identifier
  def escape_identifier(connection, identifier)
    connection.raw_connection.quote_ident(identifier)
  end

  # Escapes an object for use as a database value
  def escape_value(connection, value)
    connection.quote(value)
  end
end
