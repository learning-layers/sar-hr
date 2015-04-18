RSpec.describe User do
  it 'should have a valid factory' do
    expect(create(:user)).to be_valid
  end

  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end
end
