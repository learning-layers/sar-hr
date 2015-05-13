RSpec.describe ChannelPolicy do
  subject { ChannelPolicy.new(user, channel) }

  let(:user)    { create(:user) }
  let(:channel) { Channel.new(:global) }

  context 'when accessing the global channel' do
    it { should permit_action(:show) }
  end

  context 'when accessing some other channel' do
    let(:channel) { Channel.new(:secret) }
    it { should_not permit_action(:show) }
  end
end
