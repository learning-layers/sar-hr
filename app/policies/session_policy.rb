class SessionPolicy < Struct.new(:user, :session)
  def destroy?
    # Users can only delete their own sessions
    user == session.user
  end

  def force_unique?
    # Basically the same as the destroy? policy but semantically different,
    # as this has to do with destroying other active sessions.
    user == session.user
  end
end
