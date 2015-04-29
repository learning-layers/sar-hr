RSpec.describe TokenSet do
  subject { TokenSet.create!(user: create(:user)) }

  describe 'validations' do
    it { should validate_presence_of(:identifier) }
  end

  describe 'attributes' do
    it { should serialize(:tokens) }
    it { should have_readonly_attribute(:tokens) }

    it 'generates a token when created' do
      expect(subject.tokens.size).to eq(1)
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe '#add_token' do
    let(:token)  { subject.add_token }

    it 'creates a token' do
      expect(token).to be_a(String)
      expect(subject.tokens).to include(token)
    end
  end

  describe '#remove_token' do
    let(:token) { subject.add_token }

    before do
      subject.remove_token(token)
    end

    it 'removes the token' do
      expect(subject.tokens).not_to include(token)
    end
  end

  describe '#has_token' do
    let(:token) { subject.add_token }

    it 'finds an existing token' do
      expect(subject.has_token?(token)).to eq(true)
    end

    it 'does not find a non-existent token' do
      expect(subject.has_token?('does not exist')).to eq(false)
    end

    it 'uses Devise#secure_compare' do
      expect(Devise).to \
          receive(:secure_compare).at_least(:once).and_call_original

      subject.send(:has_token?, token)
    end
  end

  describe '#generate_token' do
    it 'uses Devise#friendly_token' do
      expect(Devise).to \
          receive(:friendly_token).at_least(:once).and_call_original

      subject.send(:generate_token)
    end
  end
end
