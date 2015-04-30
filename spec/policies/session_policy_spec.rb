RSpec.describe SessionPolicy do
  subject { SessionPolicy.new(user, session) }

  let(:user)    { create(:user) }
  let(:session) { user.sessions.create! }

  context 'when modifying own' do
    it { should permit_action(:destroy) }
  end

  context 'when modifying of another user' do
    let(:session) { create(:user).sessions.create! }

    it { should_not permit_action(:destroy) }
  end
end
