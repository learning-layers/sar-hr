RSpec.describe UserPolicy do
  subject { UserPolicy.new(user, user_resource) }

  let(:user_resource) { create(:user) }

  context 'with a user' do
    let(:user) { create(:user) }

    it { should allow(:index) }
    it { should allow(:show) }

    it { should_not allow(:create) }
    it { should_not allow(:update) }
    it { should_not allow(:destroy) }

    context 'when modifying self' do
      let(:user_resource) { user }

      it { should allow(:update) }
      it { should allow(:destroy) }
    end
  end

  context 'with an admin' do
    let(:user) { create(:admin) }

    it { should allow(:index) }
    it { should allow(:show) }
    it { should allow(:create) }
    it { should allow(:update) }
    it { should allow(:destroy) }
  end
end
