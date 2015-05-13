# Just a simple wrapper around a notification channel name so we can use
# Pundit for authorisation. This could be expanded into a full-blown domain
# model later.
class Channel < Struct.new(:name)
  def to_str
    name.to_s
  end

  alias to_s to_str

  def to_sym
    name.to_sym
  end
end
