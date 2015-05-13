RSpec.shared_examples TokenAuthenticatable do
  describe 'associations' do
    it { should have_many(:sessions).dependent(:destroy) }
  end

  describe '#valid_token?' do
    let!(:session) { subject.sessions.create! }

    context 'when passed a valid token' do
      it 'returns true' do
        expect(subject.valid_token?(session.token)).to eq(true)
      end
    end

    context 'when passed an expired token' do
      let(:session) { subject.sessions.create!(expires_on: 1.hour.ago) }

      it 'returns false' do
        expect(subject.valid_token?(session.token)).to eq(false)
      end
    end

    it 'uses Devise#secure_compare' do
      expect(Devise).to \
          receive(:secure_compare).at_least(:once).and_call_original

      subject.valid_token?('some token')
    end
  end
end
