class ChannelPolicy < Struct.new(:user, :channel)
  PUBLIC_CHANNELS = [:global]

  def show?
    PUBLIC_CHANNELS.include?(channel.to_sym)
  end
end
