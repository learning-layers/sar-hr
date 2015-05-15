RSpec.describe Session do
  subject(:session) { build(:session) }

  describe 'factory' do
    it { should be_valid }
  end

  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:token) }
    it { should validate_presence_of(:expires_on) }

    it { should validate_uniqueness_of(:token) }
  end

  describe 'attributes' do
    it { should have_readonly_attribute(:token) }

    it 'sets a token using Devise#friendly_token when created' do
      expect(Devise).to receive(:friendly_token).once.and_return('token')
      expect(session.token).to eq('token')
    end

    it 'sets an expiry date when created' do
      expect(session.expires_on).to be > Time.now
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  context 'with a valid token' do
    its(:alive?) { should eq(true) }

    describe '#keep_alive' do
      it 'keeps the session alive' do
        expect(session.keep_alive).to eq(true)
        expect(session.expires_on).to be > 5.minutes.from_now
      end
    end
  end

  context 'with an expired token' do
    before do
      session.update!(expires_on: 1.hour.ago)
    end

    its(:alive?) { should eq(false) }

    describe '#keep_alive' do
      it 'does not keep the session alive' do
        expect(session.keep_alive).to eq(false)
        expect(session.expires_on).to be < Time.now
      end
    end
  end

  context 'when a session with the generated token already exists' do
    before do
      expect(Devise).to receive(:friendly_token).once.and_return(session.token)
      expect(Devise).to receive(:friendly_token).once.and_return('another')

      session.save!
    end

    it 'generates another token' do
      expect(create(:session).token).to eq('another')
    end
  end
end
