RSpec.describe User do
  subject(:user) { build(:user) }

  describe 'factory' do
    it { should be_valid }
    its(:role) { should eq('unprivileged') }

    context 'as admin' do
      subject(:user) { build(:user, :as_admin) }

      it { should be_valid }
      its(:role) { should eq('admin') }
    end
  end

  describe 'concerns' do
    before { user.save! }
    it_behaves_like TokenAuthenticatable
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:title) }
  end

  describe 'attributes' do
    it { should define_enum_for(:role) }
    it { should have_readonly_attribute(:role) }

    it { should define_enum_for(:status) }
  end

  describe 'associations' do
    it { should have_many(:sessions) }
    it { should have_and_belong_to_many(:skills) }
  end
end
