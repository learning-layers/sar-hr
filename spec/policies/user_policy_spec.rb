RSpec.describe UserPolicy do
  subject { UserPolicy.new(user, user_resource) }

  let(:user_resource) { create(:user) }

  context 'with a user' do
    let(:user) { create(:user) }

    it { should permit_action(:index) }
    it { should permit_action(:show) }

    it { should_not permit_action(:create) }
    it { should_not permit_action(:update) }
    it { should_not permit_action(:destroy) }

    context 'when modifying self' do
      let(:user_resource) { user }

      it { should permit_action(:update) }
      it { should permit_action(:destroy) }
    end
  end

  context 'with an admin' do
    let(:user) { create(:user, :as_admin) }

    it { should permit_action(:index) }
    it { should permit_action(:show) }
    it { should permit_action(:create) }
    it { should permit_action(:update) }
    it { should permit_action(:destroy) }
  end
end
