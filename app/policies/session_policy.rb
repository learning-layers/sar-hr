class SessionPolicy < Struct.new(:user, :session)
  def destroy?
    # Users can only delete their own sessions
    user == session.user
  end
end
