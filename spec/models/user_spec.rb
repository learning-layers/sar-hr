RSpec.describe User do
  subject { build(user_type) }

  let(:user_type) { :user }

  describe 'user factory' do
    it { should be_valid }
    its(:role) { should eq('unprivileged') }
  end

  describe 'admin factory' do
    let(:user_type) { :admin }

    it { should be_valid }
    its(:role) { should eq('admin') }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'attributes' do
    it { should define_enum_for(:role) }
    it { should have_readonly_attribute(:role) }
  end

  describe 'associations' do
    it { should have_one(:token_set) }

    it { should delegate_method(:tokens).to(:token_set) }
    it { should delegate_method(:add_token).to(:token_set) }
    it { should delegate_method(:has_token?).to(:token_set) }
    it { should delegate_method(:remove_token).to(:token_set) }

    it 'should create a token set when saved' do
      subject.save!
      expect(subject.token_set).to be_a(TokenSet)
    end
  end
end
