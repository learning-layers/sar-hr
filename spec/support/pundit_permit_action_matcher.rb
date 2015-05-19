RSpec::Matchers.define :permit_action do |action|
  match do |policy|
    policy.public_send("#{action}?")
  end

  failure_message do |policy|
    "#{policy.inspect} does not permit #{action} for #{policy.user.inspect}."
  end

  failure_message_when_negated do |policy|
    "#{policy.inspect} does not forbid #{action} for #{policy.user.inspect}."
  end
end
