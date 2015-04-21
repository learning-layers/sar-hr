RSpec.describe User do
  it 'should have a valid user factory' do
    user = create(:user)

    expect(user).to be_valid
    expect(user.role).to eq('unprivileged')
  end

  it 'should have a valid admin factory' do
    admin = create(:admin)

    expect(admin).to be_valid
    expect(admin.role).to eq('admin')
  end

  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it { should have_readonly_attribute(:role) }
  end
end
